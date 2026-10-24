targetScope = 'resourceGroup'

@description('The name of the deployed Function App.')
param name string

@description('Whether to read the host key.')
param enabled bool

resource functionApp 'Microsoft.Web/sites@2025-03-01' existing = {
  name: name
}

@secure()
@description('The default Functions host key, read after package deployment.')
output apiKey string? = enabled ? listKeys('${functionApp.id}/host/default', '2025-03-01').functionKeys.default : null
