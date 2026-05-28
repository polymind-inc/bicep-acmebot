targetScope = 'resourceGroup'

metadata description = 'Resolves clientId and principalId of an existing user-assigned managed identity. Used by the parent composition to wire up identity-based storage access when no system-assigned managed identity is enabled.'

@description('Required. The name of the user-assigned managed identity to look up.')
param name string

resource uami 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' existing = {
  name: name
}

@description('The client ID of the user-assigned managed identity.')
output clientId string = uami.properties.clientId

@description('The principal ID of the user-assigned managed identity.')
output principalId string = uami.properties.principalId
