# Complete Example

Deploys Acmebot on Azure Functions Flex Consumption with a fully private networking and identity posture. This example is self-contained within an existing resource group: it provisions the virtual network, subnets, and private DNS zones it needs.

It demonstrates:

- A self-contained virtual network with a Flex Consumption VNET integration subnet delegated to `Microsoft.App/environments` and a dedicated private endpoint subnet.
- Function App and Storage Account (`blob`, `queue`, `table`) Private Endpoints with private DNS zone groups, plus a Key Vault Private Endpoint managed by the example.
- Public network access disabled on the Function App, Storage Account, and Key Vault.
- A user-assigned managed identity used for both the Acmebot workload and `AzureWebJobsStorage`, with the system-assigned identity disabled.
- Zone-redundant (`ZRS`) Storage, a 90-day Log Analytics retention, and a `CanNotDelete` resource lock on the Function App.

Before deploying, replace the inline `mailAddress` value in [main.bicep](main.bicep) with the email address used for the ACME account, then create the target resource group:

```powershell
az group create `
  --name rg-acmebot-complete `
  --location eastus2

az deployment group create `
  --resource-group rg-acmebot-complete `
  --template-file .\main.bicep
```

## Notes

- The VNET integration subnet must be delegated to `Microsoft.App/environments`, be at least `/27`, and cannot host private endpoints, so a separate subnet is used for them. Ensure the `Microsoft.App` resource provider is registered in the subscription.
- Key Vault, Storage, and the Function App are reachable only over their private endpoints. Deploy from a host with line of sight to the virtual network if you need to reach them afterwards.
- This Bicep example intentionally does not create the Microsoft Entra application registration. Add an `authSettings` block directly to the module parameters when App Service Authentication should be enabled.
