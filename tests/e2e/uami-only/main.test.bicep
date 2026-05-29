targetScope = 'resourceGroup'

metadata name = 'Using a user-assigned managed identity only'
metadata description = 'This instance deploys Azure Acmebot bound to a pre-existing user-assigned managed identity (no system-assigned identity).'

@description('Optional. Azure region to create resources. Defaults to the resource group location.')
param location string = resourceGroup().location

@description('Required. The resource ID of a pre-existing user-assigned managed identity to bind to the Function App.')
param userAssignedIdentityResourceId string

var functionAppName = take('func-acmebot-${uniqueString(resourceGroup().id, deployment().name)}', 32)

resource userAssignedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' existing = {
  name: last(split(userAssignedIdentityResourceId, '/'))
  scope: resourceGroup(split(userAssignedIdentityResourceId, '/')[2], split(userAssignedIdentityResourceId, '/')[4])
}

module testDeployment '../../../main.bicep' = {
  name: take('acmebot-${uniqueString(resourceId('Microsoft.Web/sites', functionAppName), location)}-uami', 64)
  params: {
    name: functionAppName
    location: location
    acmebot: {
      version: '5.0.1'
      mailAddress: 'admin@example.com'
      vaultUri: 'https://kv-acmebot-test${environment().suffixes.keyvaultDns}/'
      // Required when no system-assigned identity is enabled; the module no longer auto-resolves it.
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
        userAssignedIdentityResourceId
      ]
    }
    // Route AzureWebJobsStorage and deployment storage through the same user-assigned identity.
    storageManagedIdentity: {
      userAssignedResourceId: userAssignedIdentityResourceId
    }
  }
}

output name string = testDeployment.outputs.name
output resourceId string = testDeployment.outputs.resourceId
