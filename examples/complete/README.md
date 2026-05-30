# Complete Example

This example deploys Acmebot with private networking and a user-assigned
managed identity. It is self-contained within an existing resource group and
creates the virtual network, subnets, private DNS zones, and private endpoints it
needs.

It demonstrates:

- A dedicated virtual network with a Flex Consumption VNET integration subnet
  delegated to `Microsoft.App/environments`.
- A separate private endpoint subnet for Key Vault, Storage, and the Function
  App.
- Private DNS zone groups for the Function App and Storage Account private
  endpoints.
- Public network access disabled on the Function App, Storage Account, and Key
  Vault.
- A user-assigned managed identity used by both Acmebot and `AzureWebJobsStorage`.
- Zone-redundant Storage, 90-day Log Analytics retention, and a `CanNotDelete`
  lock on the Function App.

## Deploy

Before deploying, replace the inline `mailAddress` value in [main.bicep](main.bicep)
with the email address used for the ACME account.

```powershell
az group create `
  --name rg-acmebot-complete `
  --location eastus2

az deployment group create `
  --resource-group rg-acmebot-complete `
  --template-file .\main.bicep
```

## Notes

- The VNET integration subnet must be at least `/27`, delegated to
  `Microsoft.App/environments`, and separate from the private endpoint subnet.
- Ensure the `Microsoft.App` resource provider is registered in the subscription.
- Key Vault, Storage, and the Function App are reachable only through private
  endpoints after deployment.
- This example intentionally does not create a Microsoft Entra application
  registration. Add `authSettings` to the module parameters when App Service
  Authentication should be enabled.
