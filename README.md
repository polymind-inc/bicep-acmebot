# Azure Acmebot Bicep Module

Deploy Azure Acmebot on Azure Functions Flex Consumption with managed identity
storage access, optional private networking, optional App Service Authentication,
and optional diagnostics.

This repository provides an independent Bicep implementation. It is not an
official Azure Verified Module (AVM), but it follows AVM conventions where they
fit and composes published AVM modules for the underlying Azure resources.

## What It Deploys

- Azure Functions Flex Consumption app for Acmebot
- App Service Plan `FC1`
- Storage Account and deployment package container
- Log Analytics Workspace and Application Insights, unless existing resources are supplied
- Optional diagnostic settings
- Optional Microsoft Entra ID and custom OpenID Connect authentication
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
- Diagnostic settings are not created by default, matching the Terraform module.
  Existing consumers can opt in with `managedDiagnosticSettingsEnabled: true`,
  or supply explicit Function App `diagnosticSettings`.
- The module-level `lock` applies to the Function App and its private endpoints.
  Storage does not inherit this lock; use each Storage private endpoint's `lock`
  to lock that endpoint explicitly.
- Set `privateEndpointsManageDnsZoneGroup: false` when private DNS is managed
  externally. This applies to both Function App and Storage private endpoints.
- `applicationInsights.create` defaults to whether `resourceId` is absent.
  Set `create: false` with an existing component, including an ID supplied by
  another deployment. Its workspace is reused when no workspace ID is supplied.
- `acmebot.dnsProviders` must include at least one DNS provider, and
  `acmebot.version` must target a published Acmebot v5 or later release. The package
  URL is `https://github.com/polymind-inc/acmebot/releases/download/v<version>/acmebot.zip`.
- `acmebot.managedIdentityClientId` is checked against the identities attached
  to the deployed Function App. Reserved Acmebot, Storage, and authentication
  secret app settings cannot be overridden through `additionalAppSettings`.
- Secret values passed through `acmebot`, `authSettings`, and
  `additionalAppSettings` are still configured as Function App settings.

## Authentication

Use `authSettings.microsoftEntra` for Microsoft Entra ID. The existing
`authSettings.activeDirectory` name remains supported. Supply `clientId`,
`tenantAuthEndpoint`, and `clientSecret`, or pass the secret separately through
the secure `authSettingsClientSecret` parameter. A secret may be omitted when
authentication is disabled.

For custom OIDC, configure providers by name and select `defaultProvider`:

```bicep
authSettings: {
  enabled: true
  defaultProvider: 'example_oidc'
  customOpenIdConnectProviders: {
    example_oidc: {
      clientId: oidcClientId
      clientSecret: oidcClientSecret
      wellKnownOpenIdConfiguration: 'https://identity.example.com/.well-known/openid-configuration'
    }
  }
}
```

Provider names can contain ASCII letters, digits, periods, and underscores.
`microsoft_entra` and `azureactivedirectory` are reserved, case-insensitively.
The module creates `CUSTOM_OIDC_<name>_AUTHENTICATION_SECRET` app settings and
references them from `authsettingsV2` using `ClientSecretPost`. Entra and custom
providers can be configured together; an enabled default provider must exist.

## Package Deployment

Set `skipPackageDeployment: true` to provision infrastructure and deploy the ZIP
separately, for example from a runner with access to the private Function App.
`exportApiKey` must be false in this mode. Otherwise, host keys are read only
after package deployment finishes.

Terraform's AzAPI provider retries Storage authorization propagation errors.
ARM/Bicep has no equivalent per-resource retry setting. If `onedeploy` fails
with `AuthorizationPermissionMismatch` or `AuthorizationFailure` immediately
after Storage RBAC creation, wait for propagation and rerun the deployment.
For a separate deployment, download the release asset and run:

```powershell
az functionapp deployment source config-zip `
  --resource-group rg-acmebot `
  --name func-acmebot-dev `
  --src ./acmebot.zip
```

## Terraform Alignment

This update follows Terraform `master` at `844bcc4` and the custom OIDC work
in the supplied local Terraform checkout at `3e94ea2`. Local values, module
ordering, Storage endpoint references, identities, and deployment dependencies
follow the Terraform structure. Bicep retains AVM-native ARM property names,
arrays for private endpoints, and deterministic `uniqueString` naming.

## Outputs

| Output | Description |
| --- | --- |
| `name` | The name of the Function App. |
| `resourceId` | The resource ID of the Function App. |
| `resource` | The deployed Function App resource, exported securely. |
| `systemAssignedMIPrincipalId` | The principal ID of the system-assigned managed identity. |
| `privateEndpoints` | The Function App private endpoints. |
| `storageAccountPrivateEndpoints` | The Storage Account private endpoints. |
| `storageAccountName` | The Storage Account name. |
| `storageAccountResourceId` | The Storage Account resource ID. |
| `apiKey` | The default Functions host key. Null unless `exportApiKey` is `true`. |

## Referenced Public Modules

- `br/public:avm/res/web/site:0.24.0`
- `br/public:avm/res/web/serverfarm:0.7.0`
- `br/public:avm/res/storage/storage-account:0.33.1`
- `br/public:avm/res/operational-insights/workspace:0.16.1`
- `br/public:avm/res/insights/component:0.8.0`
