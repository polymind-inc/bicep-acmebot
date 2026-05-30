targetScope = 'resourceGroup'

metadata name = 'Azure Acmebot'
metadata description = 'Deploys Azure Acmebot on Azure Functions Flex Consumption using AVM-aligned conventions and published Bicep modules.'

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
  environment: ('AzureCloud' | 'AzureChinaCloud' | 'AzureUSGovernment')?
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
  algorithm: ('HS256' | 'HS384' | 'HS512')?
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
  defaultToOAuthAuthentication: bool?
  allowSharedKeyAccess: bool?
  requireInfrastructureEncryption: bool?
  publicNetworkAccess: storageAccountPublicNetworkAccessType?
  blobServices: blobServicesType?
  networkAcls: object?
  tags: object?
}

@export()
type ipRestrictionDefaultActionType = 'Allow' | 'Deny'

@export()
type storageAccountReplicationType = 'LRS' | 'GRS' | 'RAGRS' | 'ZRS' | 'GZRS' | 'RAGZRS'

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
  restorePolicyEnabled: bool?
  restorePolicyDays: int?
}

@export()
type deploymentContainerType = {
  name: string?
}

@export()
type servicePlanType = {
  name: string?
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

@description('Optional. Diagnostic settings for the Function App, using an AVM-aligned diagnosticSettings shape.')
param diagnosticSettings diagnosticSettingFullType[] = []

@description('Optional. Whether the module creates default diagnostic settings for the Function App and Storage Account resources to the module-managed or supplied Log Analytics workspace. When diagnosticSettings is set, those Function App settings are used instead of the default.')
param managedDiagnosticSettingsEnabled bool = true

@description('Optional. Private endpoints for the Function App, using an AVM-aligned web/site privateEndpoints array shape.')
param privateEndpoints privateEndpointType[] = []

@description('Optional. Private endpoints for the Storage Account, using an AVM-aligned storage-account privateEndpoints array shape.')
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

@description('Optional. Managed identity used by AzureWebJobsStorage and Flex Consumption deployment storage. When unset, the Function App system-assigned managed identity is used. Required (along with acmebot.managedIdentityClientId) when managedIdentities.systemAssigned is false; the module does not auto-select an attached user-assigned identity.')
param storageManagedIdentity storageManagedIdentityType = {}

@description('Optional. Resource lock configuration applied to the Function App and inherited by private endpoints unless endpoint inheritance is disabled.')
param lock lockType?

@description('Optional. Role assignments for the Function App, using an AVM-aligned roleAssignments shape.')
param roleAssignments roleAssignmentType[] = []

@description('Optional. Storage Account settings for the Function App deployment package. Use AVM-aligned storage-account parameter names where applicable.')
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
@description('Optional. Maximum scale-out instance count for the Function App. Defaults to 10.')
param maximumInstanceCount int?

@allowed([
  512
  2048
  4096
])
@description('Optional. Memory size in MB for Flex Consumption instances.')
param instanceMemoryInMb int?

@description('Optional. Whether to read and export the default function host key.')
param exportApiKey bool = false

@description('Optional. Enable or disable telemetry for referenced published Azure Verified Modules. This module does not deploy its own telemetry deployment.')
param enableTelemetry bool = false

var functionAppName = name
var resourceTags = tags
var subscriptionId = subscription().subscriptionId
var resourceGroupName = resourceGroup().name
var subscriptionRootResourceId = subscription().id

var functionPublicNetworkAccess = publicNetworkAccess ?? 'Disabled'
var storagePublicNetworkAccess = storageAccount.?publicNetworkAccess ?? 'Disabled'
var functionPrivateEndpointServices = [for endpoint in privateEndpoints: toLower(endpoint.service)]
var storagePrivateEndpointServices = [for endpoint in storageAccountPrivateEndpoints: toLower(endpoint.service)]
var storagePrivateEndpointSubnetResourceIds = [
  for endpoint in storageAccountPrivateEndpoints: toLower(endpoint.subnetResourceId)
]

var validatedPrivateEndpoints = functionPublicNetworkAccess == 'Enabled' || contains(
    functionPrivateEndpointServices,
    'sites'
  )
  ? privateEndpoints
  : fail('privateEndpoints must include a sites endpoint when publicNetworkAccess is Disabled or unset.')
var storagePrivateEndpointsWithRequiredServices = storagePublicNetworkAccess == 'Enabled' || (contains(
    storagePrivateEndpointServices,
    'blob'
  ) && contains(storagePrivateEndpointServices, 'queue') && contains(storagePrivateEndpointServices, 'table'))
  ? storageAccountPrivateEndpoints
  : fail('storageAccountPrivateEndpoints must include blob, queue, and table endpoints when storageAccount.publicNetworkAccess is Disabled, SecuredByPerimeter, or unset.')
var storagePrivateEndpointsRequireVnetIntegration = empty(storagePrivateEndpointsWithRequiredServices) || virtualNetworkSubnetId != null
  ? storagePrivateEndpointsWithRequiredServices
  : fail('virtualNetworkSubnetId must be set when storageAccountPrivateEndpoints is set so the Function App can route Storage Account traffic through the virtual network.')
var storagePrivateEndpointsRequiredForVnetIntegration = virtualNetworkSubnetId == null || !empty(storagePrivateEndpointsRequireVnetIntegration)
  ? storagePrivateEndpointsRequireVnetIntegration
  : fail('storageAccountPrivateEndpoints must be set when virtualNetworkSubnetId is set so the Function App can access its Storage Account through Private Endpoint.')
var validatedStorageAccountPrivateEndpoints = virtualNetworkSubnetId == null || !contains(
    storagePrivateEndpointSubnetResourceIds,
    toLower(virtualNetworkSubnetId ?? '')
  )
  ? storagePrivateEndpointsRequiredForVnetIntegration
  : fail('storageAccountPrivateEndpoints[*].subnetResourceId must be different from virtualNetworkSubnetId because the Flex Consumption VNET integration subnet cannot be used for private endpoints.')

var siteConfigIpRestrictionDefaultAction = siteConfig.?ipSecurityRestrictionsDefaultAction ?? 'Deny'
var siteConfigScmIpRestrictionDefaultAction = siteConfig.?scmIpSecurityRestrictionsDefaultAction ?? 'Deny'
var siteConfigScmUseMainIpRestriction = siteConfig.?scmIpSecurityRestrictionsUseMain ?? true
var siteConfigVnetRouteAllEnabled = siteConfig.?vnetRouteAllEnabled ?? (virtualNetworkSubnetId != null)

var normalizedFunctionName = toLower(functionAppName)
var sanitizedFunctionName = replace(replace(replace(normalizedFunctionName, '-', ''), '_', ''), '.', '')
// Build a valid Storage container name segment, mirroring the Terraform module:
// drop characters that are invalid in container names, collapse consecutive hyphens,
// cap the length, then trim leading/trailing hyphens so the assembled name can never
// contain "--" or a boundary hyphen. The five collapse passes fully reduce any run of
// hyphens within the 32-character Function App name limit.
var containerNameCleaned = replace(replace(normalizedFunctionName, '_', ''), '.', '')
var containerNameCollapsed = replace(
  replace(replace(replace(replace(containerNameCleaned, '--', '-'), '--', '-'), '--', '-'), '--', '-'),
  '--',
  '-'
)
var containerNameTruncated = take(containerNameCollapsed, 43)
var containerNameNoLeadingHyphen = startsWith(containerNameTruncated, '-')
  ? substring(containerNameTruncated, 1)
  : containerNameTruncated
var sanitizedContainerName = endsWith(containerNameNoLeadingHyphen, '-')
  ? substring(containerNameNoLeadingHyphen, 0, max(length(containerNameNoLeadingHyphen) - 1, 0))
  : containerNameNoLeadingHyphen
var uniqueToken = uniqueString(subscriptionId, resourceGroupName, functionAppName)

var storageAccountName = storageAccount.?name ?? 'st${take(sanitizedFunctionName, 16)}${take(uniqueToken, 6)}'
var deploymentContainerName = deploymentContainer.?name ?? 'app-package-${sanitizedContainerName}-${take(uniqueToken, 7)}'
var servicePlanName = servicePlan.?name ?? 'asp-${functionAppName}'
var logAnalyticsWorkspaceName = logAnalyticsWorkspace.?name ?? 'log-${functionAppName}'
var applicationInsightsName = applicationInsights.?name ?? 'appi-${functionAppName}'
var logAnalyticsWorkspaceResourceIdInput = logAnalyticsWorkspace.?resourceId ?? ''
var applicationInsightsResourceIdInput = applicationInsights.?resourceId ?? ''
var existingApplicationInsightsResourceIdParts = split(applicationInsightsResourceIdInput, '/')
var functionAppResourceId = resourceId('Microsoft.Web/sites', functionAppName)
var servicePlanResourceId = resourceId('Microsoft.Web/serverfarms', servicePlanName)
var logAnalyticsWorkspaceResourceId = resourceId('Microsoft.OperationalInsights/workspaces', logAnalyticsWorkspaceName)
var applicationInsightsResourceId = resourceId('Microsoft.Insights/components', applicationInsightsName)
var storageAccountResourceId = resourceId('Microsoft.Storage/storageAccounts', storageAccountName)
var servicePlanDeploymentName = take('acmebot-${uniqueString(servicePlanResourceId, location)}-serverfarm', 64)
var logAnalyticsWorkspaceDeploymentName = take(
  'acmebot-${uniqueString(logAnalyticsWorkspaceResourceId, location)}-workspace',
  64
)
var applicationInsightsDeploymentName = take(
  'acmebot-${uniqueString(applicationInsightsResourceId, location)}-appi',
  64
)
var storageAccountDeploymentName = take('acmebot-${uniqueString(storageAccountResourceId, location)}-storage', 64)
var functionAppDeploymentName = take('acmebot-${uniqueString(functionAppResourceId, location)}-site', 64)

// Mirror the Terraform module: only create a managed Log Analytics workspace when
// neither an existing workspace nor an existing Application Insights component is
// supplied. When an existing Application Insights is supplied without a workspace,
// reuse that component's workspace for managed diagnostics instead of creating one.
var createLogAnalyticsWorkspace = empty(logAnalyticsWorkspaceResourceIdInput) && empty(applicationInsightsResourceIdInput)
var createApplicationInsights = empty(applicationInsightsResourceIdInput)
var effectiveLogAnalyticsWorkspaceResourceId = !empty(logAnalyticsWorkspaceResourceIdInput)
  ? logAnalyticsWorkspaceResourceIdInput
  : (createLogAnalyticsWorkspace
      ? workspace!.outputs.resourceId
      : existingApplicationInsights!.properties.WorkspaceResourceId)
var applicationInsightsConnectionString = createApplicationInsights
  ? insights!.outputs.connectionString
  : existingApplicationInsights!.properties.ConnectionString
var applicationInsightsInstrumentationKey = createApplicationInsights
  ? insights!.outputs.instrumentationKey
  : existingApplicationInsights!.properties.InstrumentationKey

var acmebotVersionSegments = split(acmebot.version, '.')
var acmebotVersion = length(acmebotVersionSegments) >= 3 && int(acmebotVersionSegments[0]) >= 5
  ? acmebot.version
  : fail('acmebot.version must be a Semantic Versioning 2.0.0 version with major version 5 or greater.')
var acmebotMajorVersion = 'v${split(acmebotVersion, '.')[0]}'
#disable-next-line no-hardcoded-env-urls
var acmebotPackageUri = 'https://stacmebotprod.blob.core.windows.net/acmebot/${acmebotMajorVersion}/${acmebotVersion}.zip'

var dnsProvidersInput = acmebot.?dnsProviders ?? {}
var dnsProviderConfigured = !empty(dnsProvidersInput.?akamai ?? {}) || !empty(dnsProvidersInput.?azureDns ?? {}) || !empty(dnsProvidersInput.?azurePrivateDns ?? {}) || !empty(dnsProvidersInput.?cloudflare ?? {}) || !empty(dnsProvidersInput.?customDns ?? {}) || !empty(dnsProvidersInput.?dnsMadeEasy ?? {}) || !empty(dnsProvidersInput.?gandiLiveDns ?? {}) || !empty(dnsProvidersInput.?goDaddy ?? {}) || !empty(dnsProvidersInput.?googleDns ?? {}) || !empty(dnsProvidersInput.?ionosDns ?? {}) || !empty(dnsProvidersInput.?ovh ?? {}) || !empty(dnsProvidersInput.?powerDns ?? {}) || !empty(dnsProvidersInput.?regfish ?? {}) || !empty(dnsProvidersInput.?route53 ?? {}) || !empty(dnsProvidersInput.?transIp ?? {}) || !empty(dnsProvidersInput.?unitedDomains ?? {})
var dnsProviders = dnsProviderConfigured
  ? dnsProvidersInput
  : fail('At least one acmebot.dnsProviders entry must be configured.')
var akamai = dnsProviders.?akamai ?? null
var azureDns = dnsProviders.?azureDns ?? null
var azurePrivateDns = dnsProviders.?azurePrivateDns ?? null
var cloudflare = dnsProviders.?cloudflare ?? null
var customDns = dnsProviders.?customDns ?? null
var dnsMadeEasy = dnsProviders.?dnsMadeEasy ?? null
var gandiLiveDns = dnsProviders.?gandiLiveDns ?? null
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
var acmebotManagedIdentityClientIdInput = acmebot.?managedIdentityClientId ?? ''
var acmebotEnvironment = acmebot.?environment ?? 'AzureCloud'
var acmebotUseSystemNameServer = acmebot.?useSystemNameServer ?? (virtualNetworkSubnetId != null || acmebotEnvironment != 'AzureCloud')
var systemAssignedEnabled = managedIdentities.?systemAssigned ?? true
var attachedUserAssignedIdentityResourceIds = [
  for resourceId in (managedIdentities.?userAssignedResourceIds ?? []): toLower(resourceId)
]
var storageUserAssignedIdentityResourceIdInput = storageManagedIdentity.?userAssignedResourceId ?? ''
var storageUsesUserAssignedIdentity = !empty(storageUserAssignedIdentityResourceIdInput)
// Storage identity must be supplied explicitly. When no system-assigned identity is enabled,
// set storageManagedIdentity.userAssignedResourceId (and acmebot.managedIdentityClientId) to an
// attached user-assigned identity; the module does not auto-select one.
var storageUserAssignedIdentityResourceId = systemAssignedEnabled || storageUsesUserAssignedIdentity
  ? (!storageUsesUserAssignedIdentity || contains(
        attachedUserAssignedIdentityResourceIds,
        toLower(storageUserAssignedIdentityResourceIdInput)
      )
      ? storageUserAssignedIdentityResourceIdInput
      : fail('storageManagedIdentity.userAssignedResourceId must also be attached through managedIdentities.userAssignedResourceIds.'))
  : fail('storageManagedIdentity.userAssignedResourceId must be set when managedIdentities.systemAssigned is false.')
var acmebotManagedIdentityClientId = systemAssignedEnabled || !empty(acmebotManagedIdentityClientIdInput)
  ? (empty(acmebotManagedIdentityClientIdInput) || !empty(attachedUserAssignedIdentityResourceIds)
      ? acmebotManagedIdentityClientIdInput
      : fail('acmebot.managedIdentityClientId can only be set when at least one user-assigned managed identity is attached through managedIdentities.userAssignedResourceIds.'))
  : fail('acmebot.managedIdentityClientId must be set when managedIdentities.systemAssigned is false so Acmebot can use an attached user-assigned managed identity.')

var acmebotCommonAppSettings = {
  Acmebot__Contacts: acmebot.mailAddress
  Acmebot__Endpoint: acmebot.?acmeEndpoint ?? 'https://acme-v02.api.letsencrypt.org/directory'
  Acmebot__VaultBaseUrl: acmebot.vaultUri
  Acmebot__Environment: acmebotEnvironment
  Acmebot__RenewBeforeExpiry: string(acmebot.?renewBeforeExpiry ?? 30)
  Acmebot__UseSystemNameServer: string(acmebotUseSystemNameServer)
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

var authConfigured = authSettings != null

var authAppSettings = !authConfigured
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

var storageAccountDiagnosticSettings = managedDiagnosticSettingsEnabled ? defaultStorageAccountDiagnosticSettings : []

var storageBlobServices = union(
  union(
    {
      changeFeedEnabled: true
      changeFeedRetentionInDays: 30
      containerDeleteRetentionPolicyEnabled: true
      containerDeleteRetentionPolicyDays: 30
      deleteRetentionPolicyEnabled: true
      deleteRetentionPolicyDays: 30
      isVersioningEnabled: true
    },
    managedDiagnosticSettingsEnabled
      ? {
          diagnosticSettings: defaultStorageServiceDiagnosticSettings
        }
      : {}
  ),
  storageAccount.?blobServices ?? {},
  {
    containers: [
      {
        name: deploymentContainerName
        publicAccess: 'None'
      }
    ]
  }
)

var storageQueueServices = managedDiagnosticSettingsEnabled
  ? {
      diagnosticSettings: defaultStorageServiceDiagnosticSettings
    }
  : {}

var storageTableServices = managedDiagnosticSettingsEnabled
  ? {
      diagnosticSettings: defaultStorageServiceDiagnosticSettings
    }
  : {}

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
var storageAccountSkuName = storageAccountDefaultSkuName

var functionAppSiteConfig = union(
  {
    minTlsVersion: '1.2'
    scmMinTlsVersion: '1.2'
    ftpsState: 'Disabled'
    scmIpSecurityRestrictionsUseMain: siteConfigScmUseMainIpRestriction
    vnetRouteAllEnabled: siteConfigVnetRouteAllEnabled
    ipSecurityRestrictionsDefaultAction: siteConfigIpRestrictionDefaultAction
    scmIpSecurityRestrictionsDefaultAction: siteConfigScmIpRestrictionDefaultAction
  },
  siteConfig
)

var storagePrimaryEndpoints = storage.outputs.serviceEndpoints
var storageContainerEndpointUrl = '${storagePrimaryEndpoints.blob}${deploymentContainerName}'

var storageAuthenticationType = storageUsesUserAssignedIdentity ? 'UserAssignedIdentity' : 'SystemAssignedIdentity'
var storageIdentityConfigured = !empty(storageUserAssignedIdentityResourceId) || systemAssignedEnabled

var storageManagedIdentityClientId = storageUsesUserAssignedIdentity ? uamiLookup!.outputs.clientId : ''
var storageManagedIdentityPrincipalId = storageUsesUserAssignedIdentity
  ? uamiLookup!.outputs.principalId
  : (site.outputs.?systemAssignedMIPrincipalId ?? '')

var azureWebJobsStorageIdentityAppSettings = union(
  {
    AzureWebJobsStorage__credential: 'managedidentity'
    AzureWebJobsStorage__blobServiceUri: storagePrimaryEndpoints.blob
    AzureWebJobsStorage__queueServiceUri: storagePrimaryEndpoints.queue
    AzureWebJobsStorage__tableServiceUri: storagePrimaryEndpoints.table
  },
  storageUsesUserAssignedIdentity
    ? {
        AzureWebJobsStorage__clientId: storageManagedIdentityClientId
      }
    : {}
)

var deploymentStorageAuthentication = storageUsesUserAssignedIdentity
  ? {
      type: storageAuthenticationType
      userAssignedIdentityResourceId: storageUserAssignedIdentityResourceId
    }
  : {
      type: storageAuthenticationType
    }

var flexFunctionConfig = {
  deployment: {
    storage: {
      type: 'blobContainer'
      value: storageContainerEndpointUrl
      authentication: deploymentStorageAuthentication
    }
  }
  runtime: {
    name: 'dotnet-isolated'
    version: '10.0'
  }
  scaleAndConcurrency: {
    maximumInstanceCount: maximumInstanceCount ?? 10
    instanceMemoryMB: instanceMemoryInMb ?? 2048
  }
}

var functionAppSettings = union(
  additionalAppSettings,
  {
    APPLICATIONINSIGHTS_CONNECTION_STRING: applicationInsightsConnectionString
    APPINSIGHTS_INSTRUMENTATIONKEY: applicationInsightsInstrumentationKey
  },
  azureWebJobsStorageIdentityAppSettings,
  acmebotAppSettings,
  authAppSettings
)

var authSettingsV2 = !authConfigured
  ? null
  : {
      name: 'authsettingsV2'
      properties: {
        platform: {
          enabled: authSettings!.enabled
          runtimeVersion: '~1'
        }
        globalValidation: {
          requireAuthentication: authSettings!.enabled
          unauthenticatedClientAction: 'RedirectToLoginPage'
          redirectToProvider: 'azureactivedirectory'
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

var functionAppConfigs = concat(
  [
    {
      name: 'appsettings'
      retainCurrentAppSettings: false
      properties: functionAppSettings
    }
  ],
  authSettingsV2 == null ? [] : [authSettingsV2]
)

module storage 'br/public:avm/res/storage/storage-account:0.32.0' = {
  name: storageAccountDeploymentName
  params: {
    name: storageAccountName
    location: location
    kind: 'StorageV2'
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
    privateEndpoints: validatedStorageAccountPrivateEndpoints
    networkAcls: storageAccount.?networkAcls
    lock: lock
    tags: storageAccount.?tags ?? resourceTags
    enableTelemetry: enableTelemetry
  }
}

module serverfarm 'br/public:avm/res/web/serverfarm:0.7.0' = {
  name: servicePlanDeploymentName
  params: {
    name: servicePlanName
    location: location
    kind: 'functionapp'
    reserved: true
    skuName: 'FC1'
    zoneRedundant: servicePlan.?zoneRedundant ?? false
    tags: servicePlan.?tags ?? resourceTags
    enableTelemetry: enableTelemetry
  }
}

module workspace 'br/public:avm/res/operational-insights/workspace:0.15.1' = if (createLogAnalyticsWorkspace) {
  name: logAnalyticsWorkspaceDeploymentName
  params: {
    name: logAnalyticsWorkspaceName
    location: location
    dataRetention: logAnalyticsWorkspace.?retentionInDays ?? 30
    tags: logAnalyticsWorkspace.?tags ?? resourceTags
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
    tags: applicationInsights.?tags ?? resourceTags
    enableTelemetry: enableTelemetry
  }
}

resource existingApplicationInsights 'Microsoft.Insights/components@2020-02-02' existing = if (!createApplicationInsights) {
  scope: resourceGroup(existingApplicationInsightsResourceIdParts[2], existingApplicationInsightsResourceIdParts[4])
  name: last(existingApplicationInsightsResourceIdParts)
}

module site 'br/public:avm/res/web/site:0.23.0' = {
  name: functionAppDeploymentName
  params: {
    name: functionAppName
    location: location
    kind: 'functionapp,linux'
    serverFarmResourceId: serverfarm.outputs.resourceId
    reserved: true
    httpsOnly: true
    publicNetworkAccess: functionPublicNetworkAccess
    virtualNetworkSubnetResourceId: virtualNetworkSubnetId
    managedIdentities: managedIdentities
    siteConfig: functionAppSiteConfig
    functionAppConfig: flexFunctionConfig
    configs: functionAppConfigs
    diagnosticSettings: functionDiagnosticSettings
    privateEndpoints: validatedPrivateEndpoints
    roleAssignments: roleAssignments
    lock: lock
    tags: resourceTags
    enableTelemetry: enableTelemetry
  }
}

module uamiLookup 'modules/uami-lookup.bicep' = if (storageUsesUserAssignedIdentity) {
  name: take('acmebot-${uniqueString(storageUserAssignedIdentityResourceId, location)}-uami', 64)
  scope: resourceGroup(
    split(storageUserAssignedIdentityResourceId, '/')[2],
    split(storageUserAssignedIdentityResourceId, '/')[4]
  )
  params: {
    name: last(split(storageUserAssignedIdentityResourceId, '/'))
  }
}

resource functionApp 'Microsoft.Web/sites@2025-03-01' existing = {
  name: functionAppName
}

var storageRoleDefinitionIds = {
  storageBlobDataOwner: '${subscriptionRootResourceId}/providers/Microsoft.Authorization/roleDefinitions/b7e6dc6d-f1e8-4753-8033-0f276bb0955b'
  storageQueueDataContributor: '${subscriptionRootResourceId}/providers/Microsoft.Authorization/roleDefinitions/974c5e8b-45b9-4653-ba55-5f855dd0fb88'
  storageTableDataContributor: '${subscriptionRootResourceId}/providers/Microsoft.Authorization/roleDefinitions/0a9a7e1f-b9d0-4cc4-a60d-0319b160aaa3'
}

module siteStorageRoleAssignments 'modules/storage-role-assignments.bicep' = if (storageIdentityConfigured) {
  name: take('acmebot-${uniqueString(storageAccountResourceId, location)}-storage-rbac', 64)
  params: {
    storageAccountName: storageAccountName
    principalId: storageManagedIdentityPrincipalId
    roleDefinitionIds: storageRoleDefinitionIds
  }
  dependsOn: [
    // The child module scopes role assignments to an existing-resource symbol, so keep this dependency explicit.
    #disable-next-line no-unnecessary-dependson
    storage
  ]
}

resource packageDeployment 'Microsoft.Web/sites/extensions@2025-03-01' = {
  parent: functionApp
  name: 'onedeploy'
  #disable-next-line BCP187
  properties: {
    type: 'zip'
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
output systemAssignedMIPrincipalId string? = site.outputs.?systemAssignedMIPrincipalId

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
