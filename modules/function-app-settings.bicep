targetScope = 'resourceGroup'

@description('The name of the deployed Function App.')
param name string

@secure()
@description('The complete application settings, including workload and authentication secrets.')
param settings object

resource functionApp 'Microsoft.Web/sites@2025-03-01' existing = {
  name: name
}

resource appSettings 'Microsoft.Web/sites/config@2025-03-01' = {
  parent: functionApp
  name: 'appsettings'
  properties: settings
}
