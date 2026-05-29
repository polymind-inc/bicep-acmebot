targetScope = 'resourceGroup'

metadata name = 'Using public quickstart parameters'
metadata description = 'This instance deploys Azure Acmebot with the default supporting resources, public network access, and an Azure DNS provider configuration.'

@description('Optional. Azure region to create resources. Defaults to the resource group location.')
param location string = resourceGroup().location

var functionAppName = take('func-acmebot-${uniqueString(resourceGroup().id, deployment().name)}', 32)

module testDeployment '../../../main.bicep' = {
  name: take('acmebot-${uniqueString(resourceId('Microsoft.Web/sites', functionAppName), location)}-defaults', 64)
  params: {
    name: functionAppName
    location: location
    acmebot: {
      version: '5.0.1'
      mailAddress: 'admin@example.com'
      vaultUri: 'https://kv-acmebot-test${environment().suffixes.keyvaultDns}/'
      dnsProviders: {
        azureDns: {
          subscriptionId: subscription().subscriptionId
        }
      }
    }
    publicNetworkAccess: 'Enabled'
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

output name string = testDeployment.outputs.name
output resourceId string = testDeployment.outputs.resourceId
