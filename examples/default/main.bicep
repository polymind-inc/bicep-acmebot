targetScope = 'resourceGroup'

var suffix = take(uniqueString(resourceGroup().id), 4)
var keyVaultCertificatesOfficerRoleDefinitionId = subscriptionResourceId(
  'Microsoft.Authorization/roleDefinitions',
  'a4417e6f-fecd-4de8-b567-7b0420556985'
)

resource keyVault 'Microsoft.KeyVault/vaults@2023-07-01' = {
  name: 'kv-acmebot-${suffix}'
  location: resourceGroup().location
  tags: {
    workload: 'acmebot'
  }
  properties: {
    tenantId: subscription().tenantId
    sku: {
      family: 'A'
      name: 'standard'
    }
    enableRbacAuthorization: true
  }
}

resource keyVaultCertificatesOfficerAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  scope: keyVault
  name: guid(keyVault.id, 'func-acmebot-${suffix}', keyVaultCertificatesOfficerRoleDefinitionId)
  properties: {
    roleDefinitionId: keyVaultCertificatesOfficerRoleDefinitionId
    principalId: acmebot.outputs.systemAssignedMIPrincipalId!
    principalType: 'ServicePrincipal'
  }
}

module acmebot '../../main.bicep' = {
  name: 'acmebot-default-${suffix}'
  params: {
    name: 'func-acmebot-${suffix}'
    location: resourceGroup().location
    maximumInstanceCount: 50
    instanceMemoryInMb: 2048
    publicNetworkAccess: 'Enabled'
    tags: {
      workload: 'acmebot'
    }
    acmebot: {
      version: '5.0.0'
      mailAddress: 'admin@example.com'
      vaultUri: keyVault.properties.vaultUri
      dnsProviders: {
        azureDns: {
          subscriptionId: subscription().subscriptionId
        }
      }
    }
    managedIdentities: {
      systemAssigned: true
    }
    storageAccount: {
      publicNetworkAccess: 'Enabled'
    }
    siteConfig: {
      ipSecurityRestrictionsDefaultAction: 'Allow'
      scmIpSecurityRestrictionsDefaultAction: 'Allow'
      scmIpSecurityRestrictionsUseMain: false
    }
  }
}

output systemAssignedMIPrincipalId string = acmebot.outputs.systemAssignedMIPrincipalId!
