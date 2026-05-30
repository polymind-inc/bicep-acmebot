# Default Example

Deploys Acmebot on Azure Functions Flex Consumption with:

- A system-assigned managed identity for the Function App and Storage access.
- Azure DNS as the ACME challenge provider.
- A Key Vault target for issued certificates.

This example explicitly keeps the quickstart publicly reachable with minimal networking. The module defaults to a private posture, so public network access and permissive IP restriction defaults are set here for a low-friction sample. For private deployments, see the [`complete`](../complete) example.

Before deploying, replace the inline `mailAddress` value in [main.bicep](main.bicep) with the email address used for the ACME account, then create the target resource group:

```powershell
az group create `
  --name rg-acmebot `
  --location westus2

az deployment group create `
  --resource-group rg-acmebot `
  --template-file .\main.bicep
```
