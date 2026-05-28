# Azure Acmebot Bicep AVM

This repository provides a Bicep AVM composition for Azure Acmebot, based on the Terraform AVM implementation in `terraform-azurerm-acmebot`.

It deploys:

- Azure Functions Flex Consumption for Acmebot
- App Service Plan `FC1`
- Storage Account and deployment package container
- Log Analytics Workspace
- Application Insights
- optional App Service Authentication
- optional private endpoints, diagnostic settings, role assignments, and locks

## Usage

Deploy to an existing resource group:

```powershell
az deployment group create `
  --resource-group rg-acmebot `
  --template-file .\main.bicep `
  --parameters .\examples\main.bicepparam
```

Example parameter shape:

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
```

## Notes

The module intentionally composes published AVM Bicep modules from the public registry. Direct `Microsoft.Web/sites/extensions` is used only for the Acmebot OneDeploy package extension.

Inputs favor Bicep AVM module shapes instead of mirroring the Terraform variable model exactly. For example, Function App and Storage Account private endpoints are passed as AVM-style arrays through `privateEndpoints` and `storageAccountPrivateEndpoints`.

This module does not deploy its own AVM telemetry deployment. Telemetry for referenced published AVM modules is disabled by default and can be enabled by setting `enableTelemetry` to `true`.

When `virtualNetworkSubnetId` is set, configure storage private endpoints for the storage services Acmebot needs, typically `blob`, `queue`, and `table`, and use a different subnet from the Function App integration subnet.

Secret values passed through `acmebot` and `authSettings` are modeled as secure typed properties. `additionalAppSettings` remains a secure arbitrary object for custom app settings. These values are still configured as Function App settings.

## AVM Modules

- `br/public:avm/res/web/site:0.23.0`
- `br/public:avm/res/web/serverfarm:0.7.0`
- `br/public:avm/res/storage/storage-account:0.32.0`
- `br/public:avm/res/operational-insights/workspace:0.15.1`
- `br/public:avm/res/insights/component:0.7.1`
