targetScope = 'resourceGroup'

param name string
param clientId string

resource functionApp 'Microsoft.Web/sites@2025-03-01' existing = {
  name: name
}

var attachedClientIds = map(
  items(functionApp.identity.?userAssignedIdentities ?? {}),
  identity => toLower(identity.value.clientId)
)

@description('Whether the Acmebot client ID belongs to an identity attached to the Function App.')
output valid bool = empty(clientId) || contains(attachedClientIds, toLower(clientId))
  ? true
  : fail('acmebot.managedIdentityClientId must match an identity attached through managedIdentities.userAssignedResourceIds.')
