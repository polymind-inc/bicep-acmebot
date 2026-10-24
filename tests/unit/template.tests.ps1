$ErrorActionPreference = 'Stop'

$template = Get-Content -Raw (Join-Path $PSScriptRoot '../../main.json') | ConvertFrom-Json -AsHashtable
$checks = 0
function Assert-Contract([bool] $Condition, [string] $Message) {
    if (!$Condition) { throw $Message }
    $script:checks++
}

$resources = $template.resources
$site = $resources.site.properties.parameters
$auth = $template.variables.authSettingsV2 | ConvertTo-Json -Depth 100
$appSettings = $site.configs | ConvertTo-Json -Depth 100

Assert-Contract ($template.parameters.skipPackageDeployment.defaultValue -eq $false) 'Packages must deploy by default.'
Assert-Contract ($template.parameters.managedDiagnosticSettingsEnabled.defaultValue -eq $false) 'Managed diagnostics must be opt-in.'
Assert-Contract ($template.parameters.privateEndpointsManageDnsZoneGroup.defaultValue -eq $true) 'Private DNS zone groups must be managed by default.'
Assert-Contract ($template.parameters.authSettingsClientSecret.type -eq 'secureString') 'The separate Entra secret must stay secure.'
Assert-Contract ($template.variables.acmebotPackageUri -match 'github.com/polymind-inc/acmebot/releases/download') 'Use the Acmebot release asset.'
Assert-Contract ($template.variables.acmebotCommonAppSettings.ContainsKey('Acmebot__RequireAppRoles')) 'Use the current Acmebot app-role setting.'
Assert-Contract (!$template.variables.acmebotCommonAppSettings.ContainsKey('Acmebot__AppRoleRequired')) 'Do not emit the obsolete app-role setting.'
Assert-Contract ($appSettings -notmatch 'APPINSIGHTS_INSTRUMENTATIONKEY') 'Use only the Application Insights connection string.'
Assert-Contract ($appSettings -match 'serviceEndpoints') 'Read Storage endpoints from the module output.'
Assert-Contract ($auth -match 'customOpenIdConnectProviders') 'Custom OIDC providers must be wired to authsettingsV2.'
Assert-Contract ($auth -match 'ClientSecretPost') 'Custom OIDC must use ClientSecretPost.'
Assert-Contract ($auth -match 'CUSTOM_OIDC_') 'Custom OIDC must reference generated secret settings.'
Assert-Contract ($auth -notmatch '\.clientSecret[\W]') 'Do not put provider secrets in authsettingsV2.'
Assert-Contract ($resources.packageDeployment.condition -match 'skipPackageDeployment') 'Skipping package deployment must control the extension resource.'
Assert-Contract ($resources.packageDeployment.dependsOn -contains 'siteStorageRoleAssignments') 'Package deployment must wait for Storage RBAC.'
Assert-Contract ($resources.packageDeployment.dependsOn -contains 'functionAppIdentityValidation') 'Package deployment must wait for identity validation.'
Assert-Contract ($resources.functionHostKeys.dependsOn -contains 'packageDeployment') 'Host keys must be read after package deployment.'
Assert-Contract ($resources.functionAppIdentityValidation.dependsOn -contains 'site') 'Validate the deployed Function App identity.'
Assert-Contract ($resources.storage.properties.parameters.lock.value -eq $null) 'The Function App lock must not propagate to Storage.'
Assert-Contract ($template.outputs.apiKey.type -eq 'secureString') 'The exported host key must stay secure.'
Assert-Contract ($template.outputs.resource.type -eq 'secureObject') 'The Function App resource output must stay secure.'

Write-Output "$checks template contract checks passed."
