# Azure Acmebot Bicep Module

Deploy Azure Acmebot on Azure Functions Flex Consumption with managed identity
storage access, optional private networking, optional App Service Authentication,
and managed diagnostics.

This repository provides an independent Bicep implementation. It is not an
official Azure Verified Module (AVM), but it follows AVM conventions where they
fit and composes published AVM modules for the underlying Azure resources.

## What It Deploys

- Azure Functions Flex Consumption app for Acmebot
- App Service Plan `FC1`
- Storage Account and deployment package container
- Log Analytics Workspace and Application Insights, unless existing resources are supplied
- Managed diagnostic settings by default
- Optional App Service Authentication
- Optional private endpoints, role assignments, managed identities, and resource locks

## Quickstart

Use the default example for a minimal public deployment. Before deploying, edit
`examples/default/main.bicep` and set the `mailAddress` value for the ACME
account.

```powershell
az group create `
  --name rg-acmebot `
  --location westus2

az deployment group create `
  --resource-group rg-acmebot `
  --template-file .\examples\default\main.bicep
```

## Examples

Runnable examples are available under [`examples`](examples):

- [`default`](examples/default) - A public quickstart with minimal networking, a system-assigned managed identity, a Key Vault target, and Azure DNS.
- [`complete`](examples/complete) - A fully private deployment with VNET integration, Function App and Storage Account Private Endpoints, private DNS, a user-assigned managed identity, and a resource lock.

Both examples are resource group-scoped. Create the target resource group before
running `az deployment group create`.

## Consuming The Module

Reference `main.bicep` from another Bicep deployment when you want to supply your
own surrounding resources and configuration:

```bicep
module acmebot './main.bicep' = {
  name: 'acmebot'
  params: {
    name: 'func-acmebot-dev'
    location: resourceGroup().location
    publicNetworkAccess: 'Enabled'
    acmebot: {
      version: '5.0.1'
      mailAddress: 'admin@example.com'
      vaultUri: 'https://kv-acmebot-dev.vault.azure.net/'
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
```

## Design Notes

- The module is private by default: Function App and Storage Account public
  network access default to `Disabled`.
- Quickstart examples explicitly enable public access and do not configure App
  Service Authentication. Use them for evaluation, not as a locked-down
  production baseline.
- When `publicNetworkAccess` is unset or `Disabled`, configure a Function App
  private endpoint for the `sites` subresource.
- When Storage public access is disabled, configure `blob`, `queue`, and `table`
  private endpoints. If Storage private endpoints are configured, also set
  `virtualNetworkSubnetId` so the Function App can reach Storage through the
  virtual network.
- The Function App uses a system-assigned identity by default for Acmebot and
  `AzureWebJobsStorage`. To use a user-assigned identity, attach it through
  `managedIdentities.userAssignedResourceIds`, set
  `storageManagedIdentity.userAssignedResourceId`, and set
  `acmebot.managedIdentityClientId`.
- Default diagnostic settings are created for the Function App and Storage
  Account. Set `managedDiagnosticSettingsEnabled` to `false` to manage
  diagnostics externally.
- `acmebot.dnsProviders` must include at least one DNS provider, and
  `acmebot.version` must target an Acmebot v5 or later package.
- Secret values passed through `acmebot`, `authSettings`, and
  `additionalAppSettings` are still configured as Function App settings.

## Outputs

| Output | Description |
| --- | --- |
| `name` | The name of the Function App. |
| `resourceId` | The resource ID of the Function App. |
| `systemAssignedMIPrincipalId` | The principal ID of the system-assigned managed identity. |
| `privateEndpoints` | The Function App private endpoints. |
| `storageAccountPrivateEndpoints` | The Storage Account private endpoints. |
| `storageAccountName` | The Storage Account name. |
| `storageAccountResourceId` | The Storage Account resource ID. |
| `apiKey` | The default Functions host key. Null unless `exportApiKey` is `true`. |

## Referenced Public Modules

- `br/public:avm/res/web/site:0.23.0`
- `br/public:avm/res/web/serverfarm:0.7.0`
- `br/public:avm/res/storage/storage-account:0.32.0`
- `br/public:avm/res/operational-insights/workspace:0.15.1`
- `br/public:avm/res/insights/component:0.7.1`
