targetScope = 'resourceGroup'

var suffix = uniqueString(resourceGroup().id)
var functionAppName = take('func-acmebot-${suffix}', 32)

var tags = {
  workload: 'acmebot'
  environment: 'production'
}

var privateDnsZones = {
  sites: 'privatelink.azurewebsites.net'
  blob: 'privatelink.blob.${environment().suffixes.storage}'
  queue: 'privatelink.queue.${environment().suffixes.storage}'
  table: 'privatelink.table.${environment().suffixes.storage}'
  vault: 'privatelink.vaultcore.azure.net'
}

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2023-11-01' = {
  name: 'vnet-acmebot-${suffix}'
  location: resourceGroup().location
  tags: tags
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'snet-functions'
        properties: {
          addressPrefix: '10.0.0.0/26'
          delegations: [
            {
              name: 'Microsoft.App.environments'
              properties: {
                serviceName: 'Microsoft.App/environments'
              }
            }
          ]
        }
      }
      {
        name: 'snet-private-endpoints'
        properties: {
          addressPrefix: '10.0.1.0/26'
          privateEndpointNetworkPolicies: 'Disabled'
        }
      }
    ]
  }
}

resource sitesPrivateDnsZone 'Microsoft.Network/privateDnsZones@2020-06-01' = {
  name: privateDnsZones.sites
  location: 'global'
  tags: tags
}

resource blobPrivateDnsZone 'Microsoft.Network/privateDnsZones@2020-06-01' = {
  name: privateDnsZones.blob
  location: 'global'
  tags: tags
}

resource queuePrivateDnsZone 'Microsoft.Network/privateDnsZones@2020-06-01' = {
  name: privateDnsZones.queue
  location: 'global'
  tags: tags
}

resource tablePrivateDnsZone 'Microsoft.Network/privateDnsZones@2020-06-01' = {
  name: privateDnsZones.table
  location: 'global'
  tags: tags
}

resource vaultPrivateDnsZone 'Microsoft.Network/privateDnsZones@2020-06-01' = {
  name: privateDnsZones.vault
  location: 'global'
  tags: tags
}

resource sitesPrivateDnsZoneLink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2020-06-01' = {
  parent: sitesPrivateDnsZone
  name: 'vnl-sites'
  location: 'global'
  tags: tags
  properties: {
    registrationEnabled: false
    virtualNetwork: {
      id: virtualNetwork.id
    }
  }
}

resource blobPrivateDnsZoneLink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2020-06-01' = {
  parent: blobPrivateDnsZone
  name: 'vnl-blob'
  location: 'global'
  tags: tags
  properties: {
    registrationEnabled: false
    virtualNetwork: {
      id: virtualNetwork.id
    }
  }
}

resource queuePrivateDnsZoneLink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2020-06-01' = {
  parent: queuePrivateDnsZone
  name: 'vnl-queue'
  location: 'global'
  tags: tags
  properties: {
    registrationEnabled: false
    virtualNetwork: {
      id: virtualNetwork.id
    }
  }
}

resource tablePrivateDnsZoneLink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2020-06-01' = {
  parent: tablePrivateDnsZone
  name: 'vnl-table'
  location: 'global'
  tags: tags
  properties: {
    registrationEnabled: false
    virtualNetwork: {
      id: virtualNetwork.id
    }
  }
}

resource vaultPrivateDnsZoneLink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2020-06-01' = {
  parent: vaultPrivateDnsZone
  name: 'vnl-vault'
  location: 'global'
  tags: tags
  properties: {
    registrationEnabled: false
    virtualNetwork: {
      id: virtualNetwork.id
    }
  }
}

resource userAssignedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name: take('id-acmebot-${suffix}', 128)
  location: resourceGroup().location
  tags: tags
}

resource keyVault 'Microsoft.KeyVault/vaults@2023-07-01' = {
  name: take('kv-acmebot-${suffix}', 24)
  location: resourceGroup().location
  tags: tags
  properties: {
    tenantId: subscription().tenantId
    sku: {
      family: 'A'
      name: 'standard'
    }
    enableRbacAuthorization: true
    publicNetworkAccess: 'Disabled'
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Deny'
    }
  }
}

resource keyVaultCertificatesOfficerAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  scope: keyVault
  name: guid(
    keyVault.id,
    userAssignedIdentity.id,
    subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'a4417e6f-fecd-4de8-b567-7b0420556985')
  )
  properties: {
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'a4417e6f-fecd-4de8-b567-7b0420556985')
    principalId: userAssignedIdentity.properties.principalId
    principalType: 'ServicePrincipal'
  }
}

resource keyVaultPrivateEndpoint 'Microsoft.Network/privateEndpoints@2023-11-01' = {
  name: 'pep-kv-acmebot-${suffix}'
  location: resourceGroup().location
  tags: tags
  properties: {
    subnet: {
      id: '${virtualNetwork.id}/subnets/snet-private-endpoints'
    }
    privateLinkServiceConnections: [
      {
        name: 'psc-kv-acmebot'
        properties: {
          privateLinkServiceId: keyVault.id
          groupIds: [
            'vault'
          ]
        }
      }
    ]
  }
}

resource keyVaultPrivateDnsZoneGroup 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2023-11-01' = {
  parent: keyVaultPrivateEndpoint
  name: 'default'
  properties: {
    privateDnsZoneConfigs: [
      {
        name: 'vault'
        properties: {
          privateDnsZoneId: vaultPrivateDnsZone.id
        }
      }
    ]
  }
}

module acmebot '../../main.bicep' = {
  name: 'acmebot-complete-${suffix}'
  params: {
    name: functionAppName
    location: resourceGroup().location
    maximumInstanceCount: 100
    instanceMemoryInMb: 2048
    publicNetworkAccess: 'Disabled'
    tags: tags
    acmebot: {
      version: '5.0.1'
      mailAddress: 'admin@example.com'
      vaultUri: 'https://${keyVault.name}${environment().suffixes.keyvaultDns}/'
      managedIdentityClientId: userAssignedIdentity.properties.clientId
      dnsProviders: {
        azureDns: {
          subscriptionId: subscription().subscriptionId
        }
      }
    }
    managedIdentities: {
      systemAssigned: false
      userAssignedResourceIds: [
        userAssignedIdentity.id
      ]
    }
    storageManagedIdentity: {
      userAssignedResourceId: userAssignedIdentity.id
    }
    virtualNetworkSubnetId: '${virtualNetwork.id}/subnets/snet-functions'
    storageAccount: {
      accountReplicationType: 'ZRS'
      publicNetworkAccess: 'Disabled'
    }
    storageAccountPrivateEndpoints: [
      {
        name: 'pep-${functionAppName}-blob'
        subnetResourceId: '${virtualNetwork.id}/subnets/snet-private-endpoints'
        service: 'blob'
        privateDnsZoneGroup: {
          name: 'default'
          privateDnsZoneGroupConfigs: [
            {
              name: 'blob'
              privateDnsZoneResourceId: blobPrivateDnsZone.id
            }
          ]
        }
      }
      {
        name: 'pep-${functionAppName}-queue'
        subnetResourceId: '${virtualNetwork.id}/subnets/snet-private-endpoints'
        service: 'queue'
        privateDnsZoneGroup: {
          name: 'default'
          privateDnsZoneGroupConfigs: [
            {
              name: 'queue'
              privateDnsZoneResourceId: queuePrivateDnsZone.id
            }
          ]
        }
      }
      {
        name: 'pep-${functionAppName}-table'
        subnetResourceId: '${virtualNetwork.id}/subnets/snet-private-endpoints'
        service: 'table'
        privateDnsZoneGroup: {
          name: 'default'
          privateDnsZoneGroupConfigs: [
            {
              name: 'table'
              privateDnsZoneResourceId: tablePrivateDnsZone.id
            }
          ]
        }
      }
    ]
    privateEndpoints: [
      {
        name: 'pep-${functionAppName}-sites'
        subnetResourceId: '${virtualNetwork.id}/subnets/snet-private-endpoints'
        service: 'sites'
        privateDnsZoneGroup: {
          name: 'default'
          privateDnsZoneGroupConfigs: [
            {
              name: 'sites'
              privateDnsZoneResourceId: sitesPrivateDnsZone.id
            }
          ]
        }
      }
    ]
    siteConfig: {
      vnetRouteAllEnabled: true
    }
    logAnalyticsWorkspace: {
      retentionInDays: 90
    }
    lock: {
      kind: 'CanNotDelete'
    }
  }
  dependsOn: [
    sitesPrivateDnsZoneLink
    blobPrivateDnsZoneLink
    queuePrivateDnsZoneLink
    tablePrivateDnsZoneLink
    vaultPrivateDnsZoneLink
    keyVaultCertificatesOfficerAssignment
    keyVaultPrivateDnsZoneGroup
  ]
}

output functionAppName string = acmebot.outputs.name
output functionAppResourceId string = acmebot.outputs.resourceId
output keyVaultUri string = 'https://${keyVault.name}${environment().suffixes.keyvaultDns}/'
output userAssignedIdentityPrincipalId string = userAssignedIdentity.properties.principalId
output privateEndpoints array = acmebot.outputs.privateEndpoints
output storageAccountPrivateEndpoints array = acmebot.outputs.storageAccountPrivateEndpoints
