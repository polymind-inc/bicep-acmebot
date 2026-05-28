targetScope = 'resourceGroup'

metadata name = 'Azure Acmebot'
metadata description = 'Deploys Azure Acmebot on Azure Functions Flex Consumption by composing Azure Verified Modules.'

import { diagnosticSettingFullType } from 'br/public:avm/utl/types/avm-common-types:0.6.1'
import { lockType } from 'br/public:avm/utl/types/avm-common-types:0.6.1'
import { managedIdentityAllType } from 'br/public:avm/utl/types/avm-common-types:0.6.1'
import { roleAssignmentType } from 'br/public:avm/utl/types/avm-common-types:0.6.1'

@export()
type acmebotType = {
  version: string
  mailAddress: string
  vaultUri: string
  acmeEndpoint: string?
  environment: string?
  mitigateChainOrder: bool?
  appRoleRequired: bool?
  dnsProviders: dnsProvidersType?
  externalAccountBinding: externalAccountBindingType?
  webhookUrl: string?
  managedIdentityClientId: string?
}

@export()
type dnsProvidersType = {
  azureDns: azureDnsType?
  azurePrivateDns: azureDnsType?
  cloudflare: cloudflareType?
  customDns: customDnsType?
  dnsMadeEasy: dnsMadeEasyType?
  gandi: gandiType?
  goDaddy: goDaddyType?
  googleDns: googleDnsType?
  route53: route53Type?
  transIp: transIpType?
}

@export()
type azureDnsType = {
  subscriptionId: string
}

@export()
type cloudflareType = {
  @secure()
  apiToken: string
}

@export()
type customDnsType = {
  endpoint: string
  @secure()
  apiKey: string
  apiKeyHeaderName: string?
  propagationSeconds: int?
}

@export()
type dnsMadeEasyType = {
  @secure()
  apiKey: string
  @secure()
  secretKey: string
}

@export()
type gandiType = {
  @secure()
  apiKey: string
}

@export()
type goDaddyType = {
  @secure()
  apiKey: string
  @secure()
  apiSecret: string
}

@export()
type googleDnsType = {
  @secure()
  keyFile64: string
}

@export()
type route53Type = {
  @secure()
  accessKey: string
  @secure()
  secretKey: string
  region: string
}

@export()
type transIpType = {
  customerName: string
  privateKeyName: string
}

@export()
type externalAccountBindingType = {
  keyId: string
  @secure()
  hmacKey: string
  algorithm: string
}

@export()
type authSettingsType = {
  enabled: bool
  activeDirectory: authSettingsActiveDirectoryType
}

@export()
type authSettingsActiveDirectoryType = {
  clientId: string
  @secure()
  clientSecret: string
  tenantAuthEndpoint: string
}

@export()
type privateEndpointType = {
  name: string
  location: string?
  resourceGroupResourceId: string?
  subnetResourceId: string
  service: string
  customNetworkInterfaceName: string?
  privateLinkServiceConnectionName: string?
  privateDnsZoneGroup: privateDnsZoneGroupType?
  applicationSecurityGroupResourceIds: string[]?
  ipConfigurations: privateEndpointIpConfigurationType[]?
  roleAssignments: roleAssignmentType[]?
  tags: object?
  lock: lockType?
}

@export()
type privateDnsZoneGroupType = {
  name: string
  privateDnsZoneGroupConfigs: privateDnsZoneGroupConfigType[]
}

@export()
type privateDnsZoneGroupConfigType = {
  name: string
  privateDnsZoneResourceId: string
}

@export()
type privateEndpointIpConfigurationType = {
  name: string
  properties: {
    groupId: string
    memberName: string
    privateIPAddress: string
  }
}

@export()
type tagType = object

@export()
type siteConfigType = {
  minTlsVersion: string?
  scmMinTlsVersion: string?
  ftpsState: string?
  alwaysOn: bool?
  http20Enabled: bool?
  healthCheckPath: string?
  appCommandLine: string?
}

@export()
type storageAccountType = {
  name: string?
  kind: storageAccountKindType?
  skuName: storageAccountSkuNameType?
  publicNetworkAccess: storageAccountPublicNetworkAccessType?
  blobServices: blobServicesType?
  networkAcls: object?
  tags: object?
}

@export()
type storageAccountKindType = 'BlobStorage' | 'BlockBlobStorage' | 'FileStorage' | 'Storage' | 'StorageV2'

@export()
type storageAccountSkuNameType =
  | 'PremiumV2_LRS'
  | 'PremiumV2_ZRS'
  | 'Premium_LRS'
  | 'Premium_ZRS'
  | 'StandardV2_GRS'
  | 'StandardV2_GZRS'
  | 'StandardV2_LRS'
  | 'StandardV2_ZRS'
  | 'Standard_GRS'
  | 'Standard_GZRS'
  | 'Standard_LRS'
  | 'Standard_RAGRS'
  | 'Standard_RAGZRS'
  | 'Standard_ZRS'

@export()
type storageAccountPublicNetworkAccessType = 'Disabled' | 'Enabled' | 'SecuredByPerimeter'

@export()
type sitePublicNetworkAccessType = 'Disabled' | 'Enabled'

@export()
type blobServicesType = {
  containerDeleteRetentionPolicyEnabled: bool?
  containerDeleteRetentionPolicyDays: int?
  deleteRetentionPolicyEnabled: bool?
  deleteRetentionPolicyDays: int?
  containers: storageContainerType[]?
}

@export()
type storageContainerType = {
  name: string
  publicAccess: string?
  metadata: object?
}

@export()
type deploymentContainerType = {
  name: string?
}

@export()
type servicePlanType = {
  name: string?
  kind: string?
  skuName: string?
  zoneRedundant: bool?
  tags: object?
}

@export()
type logAnalyticsWorkspaceType = {
  name: string?
  retentionInDays: int?
  tags: object?
}

@export()
type applicationInsightsType = {
  name: string?
  tags: object?
}

@export()
type webConfigType = {
  name: string
  properties: object
  kind: string?
}

@minLength(2)
@maxLength(32)
@description('Required. The name of the Function App.')
param name string

@description('Optional. Azure region to create resources. Defaults to the resource group location.')
param location string = resourceGroup().location

@description('Required. Acmebot workload configuration. Use camelCase property names.')
param acmebot acmebotType

@secure()
@description('Optional. Additional application settings for the Function App. Acmebot and authentication settings supplied by this module take precedence.')
param additionalAppSettings object = {}

@description('Optional. App Service Authentication settings for Microsoft Entra ID.')
param authSettings authSettingsType?

@description('Optional. Diagnostic settings for the Function App, using the AVM diagnosticSettings shape.')
param diagnosticSettings diagnosticSettingFullType[] = []

@description('Optional. Private endpoints for the Function App, using the AVM web/site privateEndpoints array shape.')
param privateEndpoints privateEndpointType[] = []

@description('Optional. Private endpoints for the Storage Account, using the AVM storage-account privateEndpoints array shape.')
param storageAccountPrivateEndpoints privateEndpointType[] = []

@description('Optional. Tags applied to child resources unless overridden.')
param tags tagType = {}

@description('Optional. App Service site configuration. Use the Microsoft.Web/sites siteConfig ARM shape.')
param siteConfig siteConfigType = {}

@description('Optional. Managed identity configuration for the Function App.')
param managedIdentities managedIdentityAllType = {
  systemAssigned: true
  userAssignedResourceIds: []
}

@description('Optional. Resource lock configuration applied to the Function App and inherited by private endpoints unless endpoint inheritance is disabled.')
param lock lockType?

@description('Optional. Role assignments for the Function App, using the AVM roleAssignments shape.')
param roleAssignments roleAssignmentType[] = []

@description('Optional. Storage Account settings for the Function App deployment package. Use AVM storage-account parameter names where applicable.')
param storageAccount storageAccountType = {}

@description('Optional. Storage container settings for the Function App deployment package.')
param deploymentContainer deploymentContainerType = {}

@description('Optional. App Service Plan settings.')
param servicePlan servicePlanType = {}

@description('Optional. Log Analytics workspace settings.')
param logAnalyticsWorkspace logAnalyticsWorkspaceType = {}

@description('Optional. Application Insights settings.')
param applicationInsights applicationInsightsType = {}

@description('Optional. Public network access setting for the Function App. When null, the AVM web/site module chooses its default.')
param publicNetworkAccess sitePublicNetworkAccessType?

@description('Optional. Existing subnet resource ID to use for Function App regional virtual network integration.')
param virtualNetworkSubnetId string?

@minValue(1)
@maxValue(1000)
@description('Optional. Maximum scale-out instance count for the Function App.')
param maximumInstanceCount int?

@allowed([
  512
  2048
  4096
])
@description('Optional. Memory size in MB for Flex Consumption instances.')
param instanceMemoryInMb int?

@description('Optional. Additional Web/Function App config child resources, appended after appsettings and authsettingsV2.')
param configs webConfigType[] = []

@description('Optional. Whether to read and export the default function host key.')
param exportApiKey bool = false

@description('Optional. Enable or disable telemetry for referenced published AVM modules. This module does not deploy its own AVM telemetry deployment.')
param enableTelemetry bool = false

var normalizedFunctionName = toLower(name)
var sanitizedFunctionName = replace(normalizedFunctionName, '-', '')
var uniqueToken = uniqueString(resourceGroup().id, name)

var storageAccountName = storageAccount.?name ?? take('st${take(sanitizedFunctionName, 9)}${uniqueToken}', 24)
var deploymentContainerName = deploymentContainer.?name ?? take(
  'app-package-${normalizedFunctionName}-${take(uniqueToken, 7)}',
  63
)
var servicePlanName = servicePlan.?name ?? 'asp-${name}'
var logAnalyticsWorkspaceName = logAnalyticsWorkspace.?name ?? 'log-${name}'
var applicationInsightsName = applicationInsights.?name ?? 'appi-${name}'
var functionAppResourceId = resourceId('Microsoft.Web/sites', name)
var servicePlanResourceId = resourceId('Microsoft.Web/serverfarms', servicePlanName)
var logAnalyticsWorkspaceResourceId = resourceId('Microsoft.OperationalInsights/workspaces', logAnalyticsWorkspaceName)
var applicationInsightsResourceId = resourceId('Microsoft.Insights/components', applicationInsightsName)
var storageAccountResourceId = resourceId('Microsoft.Storage/storageAccounts', storageAccountName)
var servicePlanDeploymentName = take('avm-${uniqueString(servicePlanResourceId, location)}-serverfarm', 64)
var logAnalyticsWorkspaceDeploymentName = take(
  'avm-${uniqueString(logAnalyticsWorkspaceResourceId, location)}-workspace',
  64
)
var applicationInsightsDeploymentName = take('avm-${uniqueString(applicationInsightsResourceId, location)}-appi', 64)
var storageAccountDeploymentName = take('avm-${uniqueString(storageAccountResourceId, location)}-storage', 64)
var functionAppDeploymentName = take('avm-${uniqueString(functionAppResourceId, location)}-site', 64)

var acmebotMajorVersion = 'v${split(acmebot.version, '.')[0]}'
var acmebotPackageUri = 'https://stacmebotprod.blob.${environment().suffixes.storage}/acmebot/${acmebotMajorVersion}/${acmebot.version}.zip'

var dnsProviders = acmebot.?dnsProviders ?? {}
var azureDns = dnsProviders.?azureDns ?? null
var azurePrivateDns = dnsProviders.?azurePrivateDns ?? null
var cloudflare = dnsProviders.?cloudflare ?? null
var customDns = dnsProviders.?customDns ?? null
var dnsMadeEasy = dnsProviders.?dnsMadeEasy ?? null
var gandi = dnsProviders.?gandi ?? null
var goDaddy = dnsProviders.?goDaddy ?? null
var googleDns = dnsProviders.?googleDns ?? null
var route53 = dnsProviders.?route53 ?? null
var transIp = dnsProviders.?transIp ?? null
var externalAccountBinding = acmebot.?externalAccountBinding ?? null
var webhookUrl = acmebot.?webhookUrl ?? null
var acmebotManagedIdentityClientId = acmebot.?managedIdentityClientId ?? null

var acmebotCommonAppSettings = {
  Acmebot__Contacts: acmebot.mailAddress
  Acmebot__Endpoint: acmebot.?acmeEndpoint ?? 'https://acme-v02.api.letsencrypt.org/directory'
  Acmebot__VaultBaseUrl: acmebot.vaultUri
  Acmebot__Environment: acmebot.?environment ?? 'AzureCloud'
  Acmebot__MitigateChainOrder: string(acmebot.?mitigateChainOrder ?? false)
  Acmebot__AppRoleRequired: string(acmebot.?appRoleRequired ?? false)
}

var acmebotAppSettings = union(
  acmebotCommonAppSettings,
  empty(externalAccountBinding ?? {})
    ? {}
    : {
        Acmebot__ExternalAccountBinding__KeyId: externalAccountBinding!.keyId
        Acmebot__ExternalAccountBinding__HmacKey: externalAccountBinding!.hmacKey
        Acmebot__ExternalAccountBinding__Algorithm: externalAccountBinding!.algorithm
      },
  empty(azureDns ?? {})
    ? {}
    : {
        Acmebot__AzureDns__SubscriptionId: azureDns!.subscriptionId
      },
  empty(azurePrivateDns ?? {})
    ? {}
    : {
        Acmebot__AzurePrivateDns__SubscriptionId: azurePrivateDns!.subscriptionId
      },
  empty(cloudflare ?? {})
    ? {}
    : {
        Acmebot__Cloudflare__ApiToken: cloudflare!.apiToken
      },
  empty(customDns ?? {})
    ? {}
    : union(
        {
          Acmebot__CustomDns__Endpoint: customDns!.endpoint
          Acmebot__CustomDns__ApiKey: customDns!.apiKey
        },
        empty(customDns.?apiKeyHeaderName ?? '')
          ? {}
          : {
              Acmebot__CustomDns__ApiKeyHeaderName: customDns!.apiKeyHeaderName!
            },
        customDns.?propagationSeconds == null
          ? {}
          : {
              Acmebot__CustomDns__PropagationSeconds: string(customDns!.propagationSeconds!)
            }
      ),
  empty(dnsMadeEasy ?? {})
    ? {}
    : {
        Acmebot__DnsMadeEasy__ApiKey: dnsMadeEasy!.apiKey
        Acmebot__DnsMadeEasy__SecretKey: dnsMadeEasy!.secretKey
      },
  empty(gandi ?? {})
    ? {}
    : {
        Acmebot__Gandi__ApiKey: gandi!.apiKey
      },
  empty(goDaddy ?? {})
    ? {}
    : {
        Acmebot__GoDaddy__ApiKey: goDaddy!.apiKey
        Acmebot__GoDaddy__ApiSecret: goDaddy!.apiSecret
      },
  empty(googleDns ?? {})
    ? {}
    : {
        Acmebot__GoogleDns__KeyFile64: googleDns!.keyFile64
      },
  empty(route53 ?? {})
    ? {}
    : {
        Acmebot__Route53__AccessKey: route53!.accessKey
        Acmebot__Route53__SecretKey: route53!.secretKey
        Acmebot__Route53__Region: route53!.region
      },
  empty(transIp ?? {})
    ? {}
    : {
        Acmebot__TransIp__CustomerName: transIp!.customerName
        Acmebot__TransIp__PrivateKeyName: transIp!.privateKeyName
      },
  empty(webhookUrl ?? '')
    ? {}
    : {
        Acmebot__Webhook: webhookUrl
      },
  empty(acmebotManagedIdentityClientId ?? '')
    ? {}
    : {
        Acmebot__ManagedIdentityClientId: acmebotManagedIdentityClientId
      }
)

var authAppSettings = authSettings == null
  ? {}
  : {
      MICROSOFT_PROVIDER_AUTHENTICATION_SECRET: authSettings!.activeDirectory.clientSecret
    }

var storageBlobServices = union(
  {
    containerDeleteRetentionPolicyEnabled: true
    containerDeleteRetentionPolicyDays: 7
    deleteRetentionPolicyEnabled: true
    deleteRetentionPolicyDays: 6
  },
  storageAccount.?blobServices ?? {},
  {
    containers: concat(storageAccount.?blobServices.?containers ?? [], [
      {
        name: deploymentContainerName
        publicAccess: 'None'
      }
    ])
  }
)

var storagePublicNetworkAccess = (storageAccount.?publicNetworkAccess ?? null) == null
  ? null
  : storageAccount.publicNetworkAccess!

var appSiteConfig = union(
  {
    minTlsVersion: '1.2'
    scmMinTlsVersion: '1.2'
    ftpsState: 'Disabled'
  },
  siteConfig
)

var flexFunctionConfig = {
  deployment: {
    storage: {
      type: 'blobContainer'
      value: '${storage.outputs.primaryBlobEndpoint}${deploymentContainerName}'
      authentication: {
        type: 'StorageAccountConnectionString'
        storageAccountConnectionStringName: 'AzureWebJobsStorage'
      }
    }
  }
  runtime: {
    name: 'dotnet-isolated'
    version: '10.0'
  }
  scaleAndConcurrency: union(
    maximumInstanceCount == null
      ? {}
      : {
          maximumInstanceCount: maximumInstanceCount
        },
    instanceMemoryInMb == null
      ? {}
      : {
          instanceMemoryMB: instanceMemoryInMb
        }
  )
}

var appSettings = union(
  additionalAppSettings,
  {
    AzureWebJobsStorage: storage.outputs.primaryConnectionString
    APPLICATIONINSIGHTS_CONNECTION_STRING: insights.outputs.connectionString
    APPINSIGHTS_INSTRUMENTATIONKEY: insights.outputs.instrumentationKey
    FUNCTIONS_EXTENSION_VERSION: '~4'
    FUNCTIONS_WORKER_RUNTIME: 'dotnet-isolated'
  },
  acmebotAppSettings,
  authAppSettings
)

var authConfig = authSettings == null
  ? []
  : [
      {
        name: 'authsettingsV2'
        properties: {
          platform: {
            enabled: authSettings!.enabled
            runtimeVersion: '~1'
          }
          globalValidation: {
            requireAuthentication: true
            unauthenticatedClientAction: 'RedirectToLoginPage'
          }
          identityProviders: {
            azureActiveDirectory: {
              enabled: true
              registration: {
                clientId: authSettings!.activeDirectory.clientId
                clientSecretSettingName: 'MICROSOFT_PROVIDER_AUTHENTICATION_SECRET'
                openIdIssuer: authSettings!.activeDirectory.tenantAuthEndpoint
              }
            }
          }
          login: {
            tokenStore: {
              enabled: false
            }
          }
        }
      }
    ]

var appConfigs = concat(
  [
    {
      name: 'appsettings'
      retainCurrentAppSettings: false
      properties: appSettings
    }
  ],
  authConfig,
  configs
)

module servicePlanModule 'br/public:avm/res/web/serverfarm:0.7.0' = {
  name: servicePlanDeploymentName
  params: {
    name: servicePlanName
    location: location
    kind: servicePlan.?kind ?? 'functionapp'
    reserved: true
    skuName: servicePlan.?skuName ?? 'FC1'
    zoneRedundant: servicePlan.?zoneRedundant ?? false
    tags: servicePlan.?tags ?? tags
    enableTelemetry: enableTelemetry
  }
}

module workspace 'br/public:avm/res/operational-insights/workspace:0.15.1' = {
  name: logAnalyticsWorkspaceDeploymentName
  params: {
    name: logAnalyticsWorkspaceName
    location: location
    dataRetention: logAnalyticsWorkspace.?retentionInDays ?? 30
    tags: logAnalyticsWorkspace.?tags ?? tags
    enableTelemetry: enableTelemetry
  }
}

module insights 'br/public:avm/res/insights/component:0.7.1' = {
  name: applicationInsightsDeploymentName
  params: {
    name: applicationInsightsName
    location: location
    workspaceResourceId: workspace.outputs.resourceId
    applicationType: 'web'
    tags: applicationInsights.?tags ?? tags
    enableTelemetry: enableTelemetry
  }
}

module storage 'br/public:avm/res/storage/storage-account:0.32.0' = {
  name: storageAccountDeploymentName
  params: {
    name: storageAccountName
    location: location
    kind: storageAccount.?kind ?? 'StorageV2'
    skuName: storageAccount.?skuName ?? 'Standard_LRS'
    allowBlobPublicAccess: false
    allowSharedKeyAccess: true
    minimumTlsVersion: 'TLS1_2'
    publicNetworkAccess: storagePublicNetworkAccess
    blobServices: storageBlobServices
    privateEndpoints: storageAccountPrivateEndpoints
    networkAcls: storageAccount.?networkAcls
    tags: storageAccount.?tags ?? tags
    enableTelemetry: enableTelemetry
  }
}

module site 'br/public:avm/res/web/site:0.23.0' = {
  name: functionAppDeploymentName
  params: {
    name: name
    location: location
    kind: 'functionapp,linux'
    serverFarmResourceId: servicePlanModule.outputs.resourceId
    reserved: true
    httpsOnly: true
    publicNetworkAccess: publicNetworkAccess
    virtualNetworkSubnetResourceId: virtualNetworkSubnetId
    managedIdentities: managedIdentities
    siteConfig: appSiteConfig
    functionAppConfig: flexFunctionConfig
    configs: appConfigs
    diagnosticSettings: diagnosticSettings
    privateEndpoints: privateEndpoints
    roleAssignments: roleAssignments
    lock: lock
    tags: tags
    enableTelemetry: enableTelemetry
  }
}

resource functionApp 'Microsoft.Web/sites@2025-03-01' existing = {
  name: name
}

resource packageDeployment 'Microsoft.Web/sites/extensions@2024-04-01' = {
  parent: functionApp
  name: 'onedeploy'
  #disable-next-line BCP187
  properties: {
    packageUri: acmebotPackageUri
    remoteBuild: false
  }
  dependsOn: [
    site
  ]
}

@description('The name of the Function App.')
output name string = site.outputs.name

@description('The resource ID of the Function App.')
output resourceId string = site.outputs.resourceId

@description('The principal ID of the system-assigned managed identity.')
output systemAssignedMiPrincipalId string? = site.outputs.?systemAssignedMIPrincipalId

@description('The tenant ID of the system-assigned managed identity.')
output systemAssignedMiTenantId string? = empty(site.outputs.?systemAssignedMIPrincipalId ?? '')
  ? null
  : tenant().tenantId

@description('The Function App private endpoints.')
output privateEndpoints array = site.outputs.privateEndpoints

@description('The Storage Account private endpoints.')
output storageAccountPrivateEndpoints array = storage.outputs.privateEndpoints

@description('The Storage Account name.')
output storageAccountName string = storage.outputs.name

@description('The Storage Account resource ID.')
output storageAccountResourceId string = storage.outputs.resourceId

@secure()
@description('Created default Functions API key. Null unless exportApiKey is true.')
output apiKey string? = exportApiKey
  ? listKeys('${resourceId('Microsoft.Web/sites', name)}/host/default', '2025-03-01').functionKeys.default
  : null
