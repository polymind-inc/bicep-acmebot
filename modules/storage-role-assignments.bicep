targetScope = 'resourceGroup'

@description('Required. The Storage Account name that receives role assignments.')
param storageAccountName string

@description('Required. The principal ID to assign Storage data-plane roles to.')
param principalId string

@description('Required. Role definition resource IDs keyed by stable assignment names.')
param roleDefinitionIds object

resource storageAccount 'Microsoft.Storage/storageAccounts@2024-01-01' existing = {
  name: storageAccountName
}

resource roleAssignments 'Microsoft.Authorization/roleAssignments@2022-04-01' = [
  for roleDefinition in items(roleDefinitionIds): {
    scope: storageAccount
    name: guid(storageAccount.id, roleDefinition.key, principalId)
    properties: {
      principalId: principalId
      roleDefinitionId: roleDefinition.value
      principalType: 'ServicePrincipal'
    }
  }
]
