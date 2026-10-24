targetScope = 'resourceGroup'

@secure()
param entraClientSecret string

@secure()
param oidcClientSecret string

param existingApplicationInsightsResourceId string

var suffix = uniqueString(resourceGroup().id, deployment().name)
var workload = {
  version: '5.0.1'
  mailAddress: 'admin@example.com'
  vaultUri: 'https://kv-acmebot-test${environment().suffixes.keyvaultDns}/'
  dnsProviders: {
    azureDns: {
      subscriptionId: subscription().subscriptionId
    }
  }
}

module authentication '../../../main.bicep' = {
  name: 'authentication'
  params: {
    name: take('func-auth-${suffix}', 32)
    acmebot: workload
    additionalAppSettings: {
      Acmebot__AzureDns__ManagedIdentityClientId: '33333333-3333-3333-3333-333333333333'
    }
    publicNetworkAccess: 'Enabled'
    storageAccount: {
      publicNetworkAccess: 'Enabled'
    }
    authSettings: {
      enabled: true
      defaultProvider: 'example_oidc'
      microsoftEntra: {
        clientId: '11111111-1111-1111-1111-111111111111'
        clientSecret: entraClientSecret
        tenantAuthEndpoint: '${environment().authentication.loginEndpoint}22222222-2222-2222-2222-222222222222/v2.0'
      }
      customOpenIdConnectProviders: {
        example_oidc: {
          clientId: 'example-client'
          clientSecret: oidcClientSecret
          wellKnownOpenIdConfiguration: 'https://identity.example.com/.well-known/openid-configuration'
        }
      }
    }
    exportApiKey: true
  }
}

module infrastructureOnly '../../../main.bicep' = {
  name: 'infrastructure-only'
  params: {
    name: take('func-infra-${suffix}', 32)
    acmebot: workload
    publicNetworkAccess: 'Enabled'
    storageAccount: {
      publicNetworkAccess: 'Enabled'
    }
    applicationInsights: {
      create: false
      resourceId: existingApplicationInsightsResourceId
    }
    authSettings: {
      enabled: false
      activeDirectory: {
        clientId: '11111111-1111-1111-1111-111111111111'
        tenantAuthEndpoint: '${environment().authentication.loginEndpoint}22222222-2222-2222-2222-222222222222/v2.0'
      }
    }
    skipPackageDeployment: true
    privateEndpointsManageDnsZoneGroup: false
  }
}
