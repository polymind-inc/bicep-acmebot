# Default Example

This example deploys a minimal, publicly reachable Acmebot instance on Azure
Functions Flex Consumption. It is intended as a quickstart for evaluating the
module and understanding the required Acmebot settings.

It creates:

- A Key Vault target for issued certificates.
- A Function App with a system-assigned managed identity.
- Identity-based Storage access for `AzureWebJobsStorage`.
- Azure DNS as the ACME DNS-01 challenge provider.

This example does not configure App Service Authentication. The root module
defaults to a private posture, so this example explicitly enables public network
access and permissive IP restriction defaults for a low-friction deployment. For
a private deployment, use the [`complete`](../complete) example.

## Deploy

Before deploying, replace the inline `mailAddress` value in [main.bicep](main.bicep)
with the email address used for the ACME account.

```powershell
az group create `
  --name rg-acmebot `
  --location westus2

az deployment group create `
  --resource-group rg-acmebot `
  --template-file .\main.bicep
```
