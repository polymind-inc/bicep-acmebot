# Azure Acmebot Bicep Module

This repository provides an independent Bicep module for Azure Acmebot. It is not an official Azure Verified Module (AVM); it adopts AVM conventions and design ideas where practical, and draws on the Terraform implementation in `terraform-azurerm-acmebot`.

It deploys:

- Azure Functions Flex Consumption for Acmebot
- App Service Plan `FC1`
- Storage Account and deployment package container
- Log Analytics Workspace (created unless an existing workspace or Application Insights component is supplied)
- Application Insights (created unless an existing component is supplied)
- optional App Service Authentication
- managed diagnostic settings by default
- optional private endpoints, role assignments, and locks

## Usage

Create a resource group, then deploy the default example:

```powershell
az group create `
  --name rg-acmebot `
  --location westus2

az deployment group create `
  --resource-group rg-acmebot `
  --template-file .\examples\default\main.bicep
```

Runnable examples are available under [`examples`](examples):

- [`default`](examples/default) - A public quickstart with minimal networking, a system-assigned managed identity, a Key Vault target, and Azure DNS.
- [`complete`](examples/complete) - A fully private deployment with VNET integration, Function App and Storage Account Private Endpoints, private DNS, a user-assigned managed identity, and a resource lock.

Both examples are resource group-scoped. Create the target resource group before running `az deployment group create`.
Example settings such as `mailAddress` are assigned directly in each example `main.bicep`; edit those inline values when you need different sample values.

To consume the module from another Bicep deployment, use this parameter shape:

```bicep
param location = 'japaneast'
param name = 'func-acmebot-dev'

param acmebot = {
  version: '5.0.1'
  mailAddress: 'admin@example.com'
  vaultUri: 'https://kv-acmebot-dev.vault.azure.net/'
  dnsProviders: {
    azureDns: {
      subscriptionId: '00000000-0000-0000-0000-000000000000'
    }
  }
}

param managedIdentities = {
  systemAssigned: true
}

param publicNetworkAccess = 'Enabled'

param storageAccount = {
  publicNetworkAccess: 'Enabled'
}

param siteConfig = {
  ipSecurityRestrictionsDefaultAction: 'Allow'
  scmIpSecurityRestrictionsDefaultAction: 'Allow'
  scmIpSecurityRestrictionsUseMain: false
}
```

## Notes

The module intentionally composes published Azure Verified Modules from the public registry for the underlying Azure resources. Direct `Microsoft.Web/sites/extensions` is used only for the Acmebot OneDeploy package extension.

Inputs favor AVM-aligned Bicep shapes instead of mirroring the Terraform variable model exactly. For example, Function App and Storage Account private endpoints are passed as AVM-style arrays through `privateEndpoints` and `storageAccountPrivateEndpoints`.

The module defaults to a private posture like the Terraform implementation: Function App and Storage Account public network access default to `Disabled`, and Storage diagnostics are sent to the module-managed or supplied Log Analytics workspace by default. Quickstart samples explicitly enable public access for low-friction testing.

When `publicNetworkAccess` is unset or `Disabled`, `privateEndpoints` must include a `sites` endpoint for the Function App. When `storageAccount.publicNetworkAccess` is unset, `Disabled`, or `SecuredByPerimeter`, `storageAccountPrivateEndpoints` must include `blob`, `queue`, and `table` endpoints.

Default diagnostic settings are created for the Function App and Storage Account to the module-managed or supplied Log Analytics workspace; set `managedDiagnosticSettingsEnabled` to `false` to manage diagnostics externally. Set `logAnalyticsWorkspace.resourceId` and/or `applicationInsights.resourceId` to reuse existing monitoring resources instead of creating new ones. The module creates a Log Analytics workspace only when it also creates Application Insights. When an existing `applicationInsights.resourceId` is supplied without `logAnalyticsWorkspace.resourceId`, managed diagnostic settings are sent to the Log Analytics workspace backing that Application Insights component instead of creating a new workspace; set `logAnalyticsWorkspace.resourceId` to route diagnostics elsewhere.

This module does not deploy its own telemetry deployment. Telemetry for referenced published Azure Verified Modules is disabled by default and can be enabled by setting `enableTelemetry` to `true`.

When `virtualNetworkSubnetId` is set, configure storage private endpoints for the storage services Acmebot needs, typically `blob`, `queue`, and `table`, and use a different subnet from the Function App integration subnet. Conversely, when any Storage Account private endpoint is configured, `virtualNetworkSubnetId` must also be set so the Function App can reach Storage through the virtual network.

For managed identity, the Function App uses a system-assigned identity by default, which is also used for `AzureWebJobsStorage` and the Flex Consumption deployment storage. To use an attached user-assigned identity for storage instead, set `storageManagedIdentity.userAssignedResourceId` (the identity must also be attached through `managedIdentities.userAssignedResourceIds`). When you disable the system-assigned identity by setting `managedIdentities.systemAssigned` to `false`, you must explicitly supply both `storageManagedIdentity.userAssignedResourceId` and `acmebot.managedIdentityClientId`; the module does not auto-select an attached user-assigned identity.

`acmebot.dnsProviders` must include at least one provider, and `acmebot.version` must target the Flex Consumption package layout published under Acmebot v5 or later.

Secret values passed through `acmebot` and `authSettings` are modeled as secure typed properties. `additionalAppSettings` remains a secure arbitrary object for custom app settings, but module-managed Acmebot, storage, and authentication settings take precedence. These values are still configured as Function App settings.

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
