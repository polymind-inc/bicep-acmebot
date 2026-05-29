using '../main.bicep'

param location = 'japaneast'
param name = 'func-acmebot-dev'

param acmebot = {
  version: '5.0.1'
  mailAddress: 'YOUR-EMAIL-ADDRESS'
  vaultUri: 'https://YOUR-KEY-VAULT-NAME.vault.azure.net/'
  dnsProviders: {
    azureDns: {
      subscriptionId: '00000000-0000-0000-0000-000000000000'
    }
  }
}

param managedIdentities = {
  systemAssigned: true
}

// This quickstart keeps the Function App and Storage Account publicly reachable.
// Omit these overrides and configure Private Endpoints for private deployments.
param publicNetworkAccess = 'Enabled'

param storageAccount = {
  publicNetworkAccess: 'Enabled'
}

param siteConfig = {
  ipSecurityRestrictionsDefaultAction: 'Allow'
  scmIpSecurityRestrictionsDefaultAction: 'Allow'
  scmIpSecurityRestrictionsUseMain: false
}

param maximumInstanceCount = 50
param instanceMemoryInMb = 2048

param tags = {
  workload: 'acmebot'
}

// To enable App Service Authentication, provide an existing Microsoft Entra app registration.
// param authSettings = {
//   enabled: true
//   activeDirectory: {
//     clientId: '00000000-0000-0000-0000-000000000000'
//     clientSecret: 'CLIENT-SECRET'
//     tenantAuthEndpoint: 'https://login.microsoftonline.com/00000000-0000-0000-0000-000000000000/v2.0'
//   }
// }

// Private endpoint example using AVM-aligned module shapes:
// param publicNetworkAccess = 'Disabled'
// param virtualNetworkSubnetId = '/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-network/providers/Microsoft.Network/virtualNetworks/vnet-acmebot/subnets/snet-functions'
// param storageAccount = {
//   publicNetworkAccess: 'Disabled'
// }
// To use a user-assigned managed identity for Acmebot and AzureWebJobsStorage:
// param managedIdentities = {
//   systemAssigned: false
//   userAssignedResourceIds: [
//     '/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-identity/providers/Microsoft.ManagedIdentity/userAssignedIdentities/id-acmebot'
//   ]
// }
// The module uses the first user-assigned identity above for AzureWebJobsStorage and the deployment
// storage, and resolves its client ID for Acmebot automatically. Override only if you need a
// different identity for storage, or a different Acmebot client ID:
// param storageManagedIdentity = {
//   userAssignedResourceId: '/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-identity/providers/Microsoft.ManagedIdentity/userAssignedIdentities/id-acmebot'
// }
// Add the identity client ID to the acmebot object to override auto-resolution:
// managedIdentityClientId: '00000000-0000-0000-0000-000000000000'
//
// param storageAccountPrivateEndpoints = [
//   {
//     name: 'pep-func-acmebot-dev-blob'
//     subnetResourceId: '/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-network/providers/Microsoft.Network/virtualNetworks/vnet-acmebot/subnets/snet-private-endpoints'
//     service: 'blob'
//     privateDnsZoneGroup: {
//       name: 'default'
//       privateDnsZoneGroupConfigs: [
//         {
//           name: 'blob'
//           privateDnsZoneResourceId: '/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-network/providers/Microsoft.Network/privateDnsZones/privatelink.blob.core.windows.net'
//         }
//       ]
//     }
//   }
//   {
//     name: 'pep-func-acmebot-dev-queue'
//     subnetResourceId: '/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-network/providers/Microsoft.Network/virtualNetworks/vnet-acmebot/subnets/snet-private-endpoints'
//     service: 'queue'
//     privateDnsZoneGroup: {
//       name: 'default'
//       privateDnsZoneGroupConfigs: [
//         {
//           name: 'queue'
//           privateDnsZoneResourceId: '/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-network/providers/Microsoft.Network/privateDnsZones/privatelink.queue.core.windows.net'
//         }
//       ]
//     }
//   }
//   {
//     name: 'pep-func-acmebot-dev-table'
//     subnetResourceId: '/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-network/providers/Microsoft.Network/virtualNetworks/vnet-acmebot/subnets/snet-private-endpoints'
//     service: 'table'
//     privateDnsZoneGroup: {
//       name: 'default'
//       privateDnsZoneGroupConfigs: [
//         {
//           name: 'table'
//           privateDnsZoneResourceId: '/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-network/providers/Microsoft.Network/privateDnsZones/privatelink.table.core.windows.net'
//         }
//       ]
//     }
//   }
// ]
// param privateEndpoints = [
//   {
//     name: 'pep-func-acmebot-dev-sites'
//     subnetResourceId: '/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-network/providers/Microsoft.Network/virtualNetworks/vnet-acmebot/subnets/snet-private-endpoints'
//     service: 'sites'
//     privateDnsZoneGroup: {
//       name: 'default'
//       privateDnsZoneGroupConfigs: [
//         {
//           name: 'sites'
//           privateDnsZoneResourceId: '/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-network/providers/Microsoft.Network/privateDnsZones/privatelink.azurewebsites.net'
//         }
//       ]
//     }
//   }
// ]
