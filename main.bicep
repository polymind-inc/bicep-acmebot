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
  webhookUrl: string?
  preferredChain: string?
  preferredProfile: string?
  renewBeforeExpiry: int?
  useSystemNameServer: bool?
  appRoleRequired: bool?
  managedIdentityClientId: string?
  dnsProviders: dnsProvidersType?
  externalAccountBinding: externalAccountBindingType?
}

@export()
type dnsProvidersType = {
  akamai: akamaiType?
  azureDns: azureDnsType?
  azurePrivateDns: azureDnsType?
  cloudflare: cloudflareType?
  customDns: customDnsType?
  dnsMadeEasy: dnsMadeEasyType?
  gandi: gandiLiveDnsType?
  gandiLiveDns: gandiLiveDnsType?
  goDaddy: goDaddyType?
  googleDns: googleDnsType?
  ionosDns: ionosDnsType?
  ovh: ovhType?
  powerDns: powerDnsType?
  regfish: regfishType?
  route53: route53Type?
  transIp: transIpType?
  unitedDomains: unitedDomainsType?
}

@export()
type akamaiType = {
  host: string
  @secure()
  clientToken: string
  @secure()
  clientSecret: string
  @secure()
  accessToken: string
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
type gandiLiveDnsType = {
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
type ionosDnsType = {
  @secure()
  apiKey: string
}

@export()
type ovhType = {
  endpoint: string?
  @secure()
  applicationKey: string
  @secure()
  applicationSecret: string
  @secure()
  consumerKey: string
}

@export()
type powerDnsType = {
  endpoint: string
  @secure()
  apiKey: string
  serverId: string?
}

@export()
type regfishType = {
  @secure()
  apiKey: string
}

@export()
type route53Type = {
  @secure()
  accessKey: string
  @secure()
  secretKey: string
  region: string?
}

@export()
type transIpType = {
  customerName: string
  privateKeyName: string
}

@export()
type unitedDomainsType = {
  @secure()
  apiKey: string
}

@export()
type externalAccountBindingType = {
  keyId: string
  @secure()
  hmacKey: string
  algorithm: string?
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
  scmIpSecurityRestrictionsUseMain: bool?
  vnetRouteAllEnabled: bool?
  ipSecurityRestrictionsDefaultAction: ipRestrictionDefaultActionType?
  scmIpSecurityRestrictionsDefaultAction: ipRestrictionDefaultActionType?
  ipSecurityRestrictions: object[]?
  scmIpSecurityRestrictions: object[]?
}

@export()
type storageAccountType = {
  name: string?
  accountReplicationType: storageAccountReplicationType?
  kind: storageAccountKindType?
  skuName: storageAccountSkuNameType?
  defaultToOAuthAuthentication: bool?
  allowSharedKeyAccess: bool?
  requireInfrastructureEncryption: bool?
  publicNetworkAccess: storageAccountPublicNetworkAccessType?
  blobServices: blobServicesType?
  queueServices: storageServiceType?
  tableServices: storageServiceType?
  diagnosticSettings: storageAccountDiagnosticSettingType[]?
  networkAcls: object?
  tags: object?
}

@export()
type ipRestrictionDefaultActionType = 'Allow' | 'Deny'

@export()
type storageAccountKindType = 'BlobStorage' | 'BlockBlobStorage' | 'FileStorage' | 'Storage' | 'StorageV2'

@export()
type storageAccountReplicationType = 'LRS' | 'GRS' | 'RAGRS' | 'ZRS' | 'GZRS' | 'RAGZRS'

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
  changeFeedEnabled: bool?
  changeFeedRetentionInDays: int?
  containerDeleteRetentionPolicyEnabled: bool?
  containerDeleteRetentionPolicyDays: int?
  containerDeleteRetentionPolicyAllowPermanentDelete: bool?
  deleteRetentionPolicyEnabled: bool?
  deleteRetentionPolicyDays: int?
  deleteRetentionPolicyAllowPermanentDelete: bool?
  isVersioningEnabled: bool?
  versionDeletePolicyDays: int?
  restorePolicyEnabled: bool?
  restorePolicyDays: int?
  containers: storageContainerType[]?
  diagnosticSettings: diagnosticSettingFullType[]?
}

@export()
type storageContainerType = {
  name: string
  publicAccess: string?
  metadata: object?
}

@export()
type storageServiceType = {
  diagnosticSettings: diagnosticSettingFullType[]?
}

@export()
type storageAccountDiagnosticSettingType = {
  name: string?
  metricCategories: diagnosticMetricCategoryType[]?
  logAnalyticsDestinationType: logAnalyticsDestinationType?
  workspaceResourceId: string?
  storageAccountResourceId: string?
  eventHubAuthorizationRuleResourceId: string?
  eventHubName: string?
  marketplacePartnerResourceId: string?
}

@export()
type logAnalyticsDestinationType = 'AzureDiagnostics' | 'Dedicated'

@export()
type diagnosticMetricCategoryType = {
  category: string
  enabled: bool?
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
  resourceId: string?
  name: string?
  retentionInDays: int?
  tags: object?
}

@export()
type applicationInsightsType = {
  resourceId: string?
  name: string?
  tags: object?
}

@export()
type storageManagedIdentityType = {
  userAssignedResourceId: string?
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
@description('Optional. Additional application settings for the Function App. Acmebot, storage, and authentication settings supplied by this module take precedence.')
param additionalAppSettings object = {}

@description('Optional. App Service Authentication settings for Microsoft Entra ID.')
param authSettings authSettingsType?

@description('Optional. Diagnostic settings for the Function App, using the AVM diagnosticSettings shape.')
param diagnosticSettings diagnosticSettingFullType[] = []

@description('Optional. Whether the module creates default diagnostic settings for the Function App and Storage Account resources to the module-managed or supplied Log Analytics workspace. When diagnosticSettings is set, those Function App settings are used instead of the default.')
param managedDiagnosticSettingsEnabled bool = true

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

@description('Optional. Managed identity used by AzureWebJobsStorage and Flex Consumption deployment storage. When unset, the Function App system-assigned managed identity is used.')
param storageManagedIdentity storageManagedIdentityType = {}

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

@description('Optional. Public network access setting for the Function App. Defaults to Disabled to match the Terraform module private-by-default behavior.')
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
var sanitizedFunctionName = replace(replace(replace(normalizedFunctionName, '-', ''), '_', ''), '.', '')
var sanitizedContainerName = replace(replace(normalizedFunctionName, '_', '-'), '.', '-')
var uniqueToken = uniqueString(resourceGroup().id, name)

var storageAccountName = storageAccount.?name ?? take('st${take(sanitizedFunctionName, 9)}${uniqueToken}', 24)
var deploymentContainerName = deploymentContainer.?name ?? take(
  'app-package-${sanitizedContainerName}-${take(uniqueToken, 7)}',
  63
)
var servicePlanName = servicePlan.?name ?? 'asp-${name}'
var logAnalyticsWorkspaceName = logAnalyticsWorkspace.?name ?? 'log-${name}'
var applicationInsightsName = applicationInsights.?name ?? 'appi-${name}'
var logAnalyticsWorkspaceResourceIdInput = logAnalyticsWorkspace.?resourceId ?? ''
var applicationInsightsResourceIdInput = applicationInsights.?resourceId ?? ''
var existingApplicationInsightsResourceIdParts = split(applicationInsightsResourceIdInput, '/')
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

var createLogAnalyticsWorkspace = empty(logAnalyticsWorkspaceResourceIdInput) && (empty(applicationInsightsResourceIdInput) || managedDiagnosticSettingsEnabled)
var createApplicationInsights = empty(applicationInsightsResourceIdInput)
var effectiveLogAnalyticsWorkspaceResourceId = !empty(logAnalyticsWorkspaceResourceIdInput)
  ? logAnalyticsWorkspaceResourceIdInput
  : (createLogAnalyticsWorkspace ? workspace!.outputs.resourceId : '')
var applicationInsightsConnectionString = createApplicationInsights
  ? insights!.outputs.connectionString
  : existingApplicationInsights!.properties.ConnectionString
var applicationInsightsInstrumentationKey = createApplicationInsights
  ? insights!.outputs.instrumentationKey
  : existingApplicationInsights!.properties.InstrumentationKey

var acmebotMajorVersion = 'v${split(acmebot.version, '.')[0]}'
#disable-next-line no-hardcoded-env-urls
var acmebotPackageUri = 'https://stacmebotprod.blob.core.windows.net/acmebot/${acmebotMajorVersion}/${acmebot.version}.zip'

var dnsProviders = acmebot.?dnsProviders ?? {}
var akamai = dnsProviders.?akamai ?? null
var azureDns = dnsProviders.?azureDns ?? null
var azurePrivateDns = dnsProviders.?azurePrivateDns ?? null
var cloudflare = dnsProviders.?cloudflare ?? null
var customDns = dnsProviders.?customDns ?? null
var dnsMadeEasy = dnsProviders.?dnsMadeEasy ?? null
var gandiLiveDns = dnsProviders.?gandiLiveDns ?? dnsProviders.?gandi ?? null
var goDaddy = dnsProviders.?goDaddy ?? null
var googleDns = dnsProviders.?googleDns ?? null
var ionosDns = dnsProviders.?ionosDns ?? null
var ovh = dnsProviders.?ovh ?? null
var powerDns = dnsProviders.?powerDns ?? null
var regfish = dnsProviders.?regfish ?? null
var route53 = dnsProviders.?route53 ?? null
var transIp = dnsProviders.?transIp ?? null
var unitedDomains = dnsProviders.?unitedDomains ?? null
var externalAccountBinding = acmebot.?externalAccountBinding ?? null
var webhookUrl = acmebot.?webhookUrl ?? null
var preferredChain = acmebot.?preferredChain ?? null
var preferredProfile = acmebot.?preferredProfile ?? null
var acmebotManagedIdentityClientId = acmebot.?managedIdentityClientId ?? null

var acmebotCommonAppSettings = {
  Acmebot__Contacts: acmebot.mailAddress
  Acmebot__Endpoint: acmebot.?acmeEndpoint ?? 'https://acme-v02.api.letsencrypt.org/directory'
  Acmebot__VaultBaseUrl: acmebot.vaultUri
  Acmebot__Environment: acmebot.?environment ?? 'AzureCloud'
  Acmebot__RenewBeforeExpiry: string(acmebot.?renewBeforeExpiry ?? 30)
  Acmebot__UseSystemNameServer: string(acmebot.?useSystemNameServer ?? false)
  Acmebot__AppRoleRequired: string(acmebot.?appRoleRequired ?? false)
}

var acmebotAppSettings = union(
  acmebotCommonAppSettings,
  empty(externalAccountBinding ?? {})
    ? {}
    : {
        Acmebot__ExternalAccountBinding__KeyId: externalAccountBinding!.keyId
        Acmebot__ExternalAccountBinding__HmacKey: externalAccountBinding!.hmacKey
        Acmebot__ExternalAccountBinding__Algorithm: externalAccountBinding.?algorithm ?? 'HS256'
      },
  empty(akamai ?? {})
    ? {}
    : {
        Acmebot__Akamai__Host: akamai!.host
        Acmebot__Akamai__ClientToken: akamai!.clientToken
        Acmebot__Akamai__ClientSecret: akamai!.clientSecret
        Acmebot__Akamai__AccessToken: akamai!.accessToken
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
    : {
        Acmebot__CustomDns__Endpoint: customDns!.endpoint
        Acmebot__CustomDns__ApiKey: customDns!.apiKey
        Acmebot__CustomDns__ApiKeyHeaderName: customDns.?apiKeyHeaderName ?? 'X-Api-Key'
        Acmebot__CustomDns__PropagationSeconds: string(customDns.?propagationSeconds ?? 180)
      },
  empty(dnsMadeEasy ?? {})
    ? {}
    : {
        Acmebot__DnsMadeEasy__ApiKey: dnsMadeEasy!.apiKey
        Acmebot__DnsMadeEasy__SecretKey: dnsMadeEasy!.secretKey
      },
  empty(gandiLiveDns ?? {})
    ? {}
    : {
        Acmebot__GandiLiveDns__ApiKey: gandiLiveDns!.apiKey
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
  empty(ionosDns ?? {})
    ? {}
    : {
        Acmebot__IonosDns__ApiKey: ionosDns!.apiKey
      },
  empty(ovh ?? {})
    ? {}
    : {
        Acmebot__Ovh__Endpoint: ovh.?endpoint ?? 'https://eu.api.ovh.com/1.0/'
        Acmebot__Ovh__ApplicationKey: ovh!.applicationKey
        Acmebot__Ovh__ApplicationSecret: ovh!.applicationSecret
        Acmebot__Ovh__ConsumerKey: ovh!.consumerKey
      },
  empty(powerDns ?? {})
    ? {}
    : {
        Acmebot__PowerDns__Endpoint: powerDns!.endpoint
        Acmebot__PowerDns__ApiKey: powerDns!.apiKey
        Acmebot__PowerDns__ServerId: powerDns.?serverId ?? 'localhost'
      },
  empty(regfish ?? {})
    ? {}
    : {
        Acmebot__Regfish__ApiKey: regfish!.apiKey
      },
  empty(route53 ?? {})
    ? {}
    : {
        Acmebot__Route53__AccessKey: route53!.accessKey
        Acmebot__Route53__SecretKey: route53!.secretKey
        Acmebot__Route53__Region: route53.?region ?? 'us-east-1'
      },
  empty(transIp ?? {})
    ? {}
    : {
        Acmebot__TransIp__CustomerName: transIp!.customerName
        Acmebot__TransIp__PrivateKeyName: transIp!.privateKeyName
      },
  empty(unitedDomains ?? {})
    ? {}
    : {
        Acmebot__UnitedDomains__ApiKey: unitedDomains!.apiKey
      },
  empty(webhookUrl ?? '')
    ? {}
    : {
        Acmebot__Webhook: webhookUrl
      },
  empty(preferredChain ?? '')
    ? {}
    : {
        Acmebot__PreferredChain: preferredChain
      },
  empty(preferredProfile ?? '')
    ? {}
    : {
        Acmebot__PreferredProfile: preferredProfile
      },
  empty(acmebotManagedIdentityClientId ?? '')
    ? {}
    : {
        Acmebot__ManagedIdentityClientId: acmebotManagedIdentityClientId
      }
)

var authEnabled = (authSettings != null) && authSettings!.enabled

var authAppSettings = !authEnabled
  ? {}
  : {
      MICROSOFT_PROVIDER_AUTHENTICATION_SECRET: authSettings!.activeDirectory.clientSecret
    }

var defaultFunctionDiagnosticSettings = [
  {
    workspaceResourceId: effectiveLogAnalyticsWorkspaceResourceId
  }
]

var functionDiagnosticSettings = managedDiagnosticSettingsEnabled && empty(diagnosticSettings)
  ? defaultFunctionDiagnosticSettings
  : diagnosticSettings

var defaultStorageAccountDiagnosticSettings = [
  {
    workspaceResourceId: effectiveLogAnalyticsWorkspaceResourceId
    metricCategories: [
      {
        category: 'Transaction'
      }
    ]
  }
]

var defaultStorageServiceDiagnosticSettings = [
  {
    workspaceResourceId: effectiveLogAnalyticsWorkspaceResourceId
    logCategoriesAndGroups: [
      {
        category: 'StorageRead'
      }
      {
        category: 'StorageWrite'
      }
      {
        category: 'StorageDelete'
      }
    ]
    metricCategories: [
      {
        category: 'Transaction'
      }
    ]
  }
]

var storageAccountDiagnosticSettings = storageAccount.?diagnosticSettings ?? (managedDiagnosticSettingsEnabled ? defaultStorageAccountDiagnosticSettings : [])

var userContainers = storageAccount.?blobServices.?containers ?? []
var hasDeploymentContainer = !empty(filter(userContainers, c => c.name == deploymentContainerName))

var storageBlobServices = union(
  union({
    changeFeedEnabled: true
    changeFeedRetentionInDays: 30
    containerDeleteRetentionPolicyEnabled: true
    containerDeleteRetentionPolicyDays: 30
    deleteRetentionPolicyEnabled: true
    deleteRetentionPolicyDays: 30
    isVersioningEnabled: true
  }, managedDiagnosticSettingsEnabled ? {
    diagnosticSettings: defaultStorageServiceDiagnosticSettings
  } : {}),
  storageAccount.?blobServices ?? {},
  {
    containers: hasDeploymentContainer
      ? userContainers
      : concat(userContainers, [
          {
            name: deploymentContainerName
            publicAccess: 'None'
          }
        ])
  }
)

var storageQueueServices = union(
  managedDiagnosticSettingsEnabled ? {
    diagnosticSettings: defaultStorageServiceDiagnosticSettings
  } : {},
  storageAccount.?queueServices ?? {}
)

var storageTableServices = union(
  managedDiagnosticSettingsEnabled ? {
    diagnosticSettings: defaultStorageServiceDiagnosticSettings
  } : {},
  storageAccount.?tableServices ?? {}
)

var storagePublicNetworkAccess = storageAccount.?publicNetworkAccess ?? 'Disabled'
var functionPublicNetworkAccess = publicNetworkAccess ?? 'Disabled'
var storageAccountReplication = storageAccount.?accountReplicationType ?? 'LRS'
var storageAccountDefaultSkuName = storageAccountReplication == 'GRS'
  ? 'Standard_GRS'
  : (storageAccountReplication == 'RAGRS'
      ? 'Standard_RAGRS'
      : (storageAccountReplication == 'ZRS'
          ? 'Standard_ZRS'
          : (storageAccountReplication == 'GZRS'
              ? 'Standard_GZRS'
              : (storageAccountReplication == 'RAGZRS' ? 'Standard_RAGZRS' : 'Standard_LRS'))))
var storageAccountSkuName = storageAccount.?skuName ?? storageAccountDefaultSkuName

var appSiteConfig = union(
  {
    minTlsVersion: '1.2'
    scmMinTlsVersion: '1.2'
    ftpsState: 'Disabled'
    scmIpSecurityRestrictionsUseMain: true
    vnetRouteAllEnabled: virtualNetworkSubnetId != null
    ipSecurityRestrictionsDefaultAction: 'Deny'
    scmIpSecurityRestrictionsDefaultAction: 'Deny'
  },
  siteConfig
)

var storageBlobEndpoint = 'https://${storageAccountName}.blob.${environment().suffixes.storage}'
var storageQueueEndpoint = 'https://${storageAccountName}.queue.${environment().suffixes.storage}'
var storageTableEndpoint = 'https://${storageAccountName}.table.${environment().suffixes.storage}'

var systemAssignedEnabled = managedIdentities.?systemAssigned ?? true
var storageUserAssignedIdentityResourceId = storageManagedIdentity.?userAssignedResourceId ?? ''
var hasStorageUserAssignedIdentity = !empty(storageUserAssignedIdentityResourceId)

// Storage access uses SA-MI by default. If storageManagedIdentity is configured,
// that attached UA-MI is used instead for AzureWebJobsStorage and deployment storage.
var storageUsesUserAssigned = hasStorageUserAssignedIdentity
var storageUsesSystemAssigned = !storageUsesUserAssigned && systemAssignedEnabled
var storageIdentityConfigured = storageUsesSystemAssigned || storageUsesUserAssigned

var azureWebJobsStorageMiSettings = storageUsesUserAssigned
  ? {
      AzureWebJobsStorage__credential: 'managedidentity'
      AzureWebJobsStorage__clientId: uamiLookup!.outputs.clientId
    }
  : {}

var deploymentStorageAuthentication = storageUsesUserAssigned
  ? {
      type: 'UserAssignedIdentity'
      userAssignedIdentityResourceId: storageUserAssignedIdentityResourceId
    }
  : {
      type: 'SystemAssignedIdentity'
    }

var flexFunctionConfig = {
  deployment: {
    storage: {
      type: 'blobContainer'
      value: '${storageBlobEndpoint}/${deploymentContainerName}'
      authentication: deploymentStorageAuthentication
    }
  }
  runtime: {
    name: 'dotnet-isolated'
    version: '10.0'
  }
  scaleAndConcurrency: {
    maximumInstanceCount: maximumInstanceCount ?? 40
    instanceMemoryMB: instanceMemoryInMb ?? 2048
  }
}

var appSettings = union(
  additionalAppSettings,
  {
    AzureWebJobsStorage__blobServiceUri: storageBlobEndpoint
    AzureWebJobsStorage__queueServiceUri: storageQueueEndpoint
    AzureWebJobsStorage__tableServiceUri: storageTableEndpoint
    AzureWebJobsStorage__credential: 'managedidentity'
    APPLICATIONINSIGHTS_CONNECTION_STRING: applicationInsightsConnectionString
    APPINSIGHTS_INSTRUMENTATIONKEY: applicationInsightsInstrumentationKey
  },
  azureWebJobsStorageMiSettings,
  acmebotAppSettings,
  authAppSettings
)

var authConfig = !authEnabled
  ? []
  : [
      {
        name: 'authsettingsV2'
        properties: {
          platform: {
            enabled: true
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

module workspace 'br/public:avm/res/operational-insights/workspace:0.15.1' = if (createLogAnalyticsWorkspace) {
  name: logAnalyticsWorkspaceDeploymentName
  params: {
    name: logAnalyticsWorkspaceName
    location: location
    dataRetention: logAnalyticsWorkspace.?retentionInDays ?? 30
    tags: logAnalyticsWorkspace.?tags ?? tags
    enableTelemetry: enableTelemetry
  }
}

module insights 'br/public:avm/res/insights/component:0.7.1' = if (createApplicationInsights) {
  name: applicationInsightsDeploymentName
  params: {
    name: applicationInsightsName
    location: location
    workspaceResourceId: effectiveLogAnalyticsWorkspaceResourceId
    applicationType: 'web'
    tags: applicationInsights.?tags ?? tags
    enableTelemetry: enableTelemetry
  }
}

module uamiLookup 'modules/uami-lookup.bicep' = if (storageUsesUserAssigned) {
  name: take('avm-${uniqueString(storageUserAssignedIdentityResourceId, location)}-uami', 64)
  scope: resourceGroup(
    split(storageUserAssignedIdentityResourceId, '/')[2],
    split(storageUserAssignedIdentityResourceId, '/')[4]
  )
  params: {
    name: last(split(storageUserAssignedIdentityResourceId, '/'))
  }
}

module storage 'br/public:avm/res/storage/storage-account:0.32.0' = {
  name: storageAccountDeploymentName
  params: {
    name: storageAccountName
    location: location
    kind: storageAccount.?kind ?? 'StorageV2'
    skuName: storageAccountSkuName
    allowBlobPublicAccess: false
    defaultToOAuthAuthentication: storageAccount.?defaultToOAuthAuthentication ?? true
    allowSharedKeyAccess: storageAccount.?allowSharedKeyAccess ?? false
    requireInfrastructureEncryption: storageAccount.?requireInfrastructureEncryption ?? true
    minimumTlsVersion: 'TLS1_2'
    publicNetworkAccess: storagePublicNetworkAccess
    blobServices: storageBlobServices
    queueServices: storageQueueServices
    tableServices: storageTableServices
    diagnosticSettings: storageAccountDiagnosticSettings
    privateEndpoints: storageAccountPrivateEndpoints
    networkAcls: storageAccount.?networkAcls
    lock: lock
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
    publicNetworkAccess: functionPublicNetworkAccess
    virtualNetworkSubnetResourceId: virtualNetworkSubnetId
    managedIdentities: managedIdentities
    siteConfig: appSiteConfig
    functionAppConfig: flexFunctionConfig
    configs: appConfigs
    diagnosticSettings: functionDiagnosticSettings
    privateEndpoints: privateEndpoints
    roleAssignments: roleAssignments
    lock: lock
    tags: tags
    enableTelemetry: enableTelemetry
  }
}

resource existingApplicationInsights 'Microsoft.Insights/components@2020-02-02' existing = if (!createApplicationInsights) {
  scope: resourceGroup(existingApplicationInsightsResourceIdParts[2], existingApplicationInsightsResourceIdParts[4])
  name: last(existingApplicationInsightsResourceIdParts)
}

resource functionApp 'Microsoft.Web/sites@2025-03-01' existing = {
  name: name
}

resource storageAccountRef 'Microsoft.Storage/storageAccounts@2024-01-01' existing = {
  name: storageAccountName
}

// Storage Blob Data Owner, Storage Queue Data Contributor, Storage Table Data Contributor, Storage Account Contributor.
// Required for identity-based AzureWebJobsStorage and deployment storage access on Flex Consumption.
var storageRoleDefinitionIds = [
  'b7e6dc6d-f1e8-4753-8033-0f276bb0955b'
  '974c5e8b-45b9-4653-ba55-5f855dd0fb88'
  '0a9a7e1f-b9d0-4cc4-a60d-0319b160aaa3'
  '17d1049b-9a84-46fb-8f53-869881c3d3ab'
]

var storagePrincipalId = storageUsesSystemAssigned
  ? (site.outputs.?systemAssignedMIPrincipalId ?? '')
  : (storageUsesUserAssigned ? uamiLookup!.outputs.principalId : '')

resource siteStorageRoleAssignments 'Microsoft.Authorization/roleAssignments@2022-04-01' = [
  for roleDefId in storageRoleDefinitionIds: if (storageIdentityConfigured) {
    scope: storageAccountRef
    name: guid(storageAccountRef.id, name, roleDefId)
    properties: {
      principalId: storagePrincipalId
      roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', roleDefId)
      principalType: 'ServicePrincipal'
    }
    dependsOn: [
      storage
    ]
  }
]

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
    siteStorageRoleAssignments
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
  ? listKeys('${functionApp.id}/host/default', '2025-03-01').functionKeys.default
  : null
