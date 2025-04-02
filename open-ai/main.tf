

data "azure_resource_group" "existing" {
  name = var.resource_group_name
}

data "azurerm_client_config" "current" {
}

// STORAGE ACCOUNT
resource "azurerm_storage_account" "default" {
  name                            = "${var.env}-storage"
  location                        = var.region
  resource_group_name             = var.resource_group_name
  account_tier                    = "Standard"
  account_replication_type        = "GRS"
  allow_nested_items_to_be_public = false
}

// KEY VAULT
resource "azurerm_key_vault" "default" {
  name                     = "${var.env}-kv"
  location                 = var.region
  resource_group_name      = var.resource_group_name
  tenant_id                = data.azurerm_client_config.current.tenant_id
  sku_name                 = "standard"
  purge_protection_enabled = false
}

// AzAPI AIServices
# resource "azapi_resource" "AIServicesResource" {
#   type      = "Microsoft.CognitiveServices/accounts@2023-10-01-preview"
#   name      = "${var.env}-AIServicesResource"
#   location  = var.region
#   parent_id = data.azure_resource_group.existing.id
#
#   identity {
#     type = "SystemAssigned"
#   }
#
#   body = jsonencode({
#     name = "AIServicesResource"
#     properties = {
#       //restore = true
#       customSubDomainName = "${var.env}domain"
#       apiProperties = {
#         statisticsEnabled = false
#       }
#     }
#     kind = "AIServices"
#     sku = {
#       name = "S0"
#     }
#   })
#
#   response_export_values = ["*"]
# }
#
# // Azure AI Hub
# resource "azapi_resource" "hub" {
#   type                = "Microsoft.MachineLearningServices/workspaces@2024-04-01-preview"
#   name                = "${var.env}-aih"
#   location            = var.region
#   resource_group_name = var.resource_group_name
#
#   identity {
#     type = "SystemAssigned"
#   }
#
#   body = jsonencode({
#     properties = {
#       description    = "This is my Azure AI hub"
#       friendlyName   = "My Hub"
#       storageAccount = azurerm_storage_account.default.id
#       keyVault       = azurerm_key_vault.default.id
#
#       /* Optional: To enable these field, the corresponding dependent resources need to be uncommented.
#       applicationInsight = azurerm_application_insights.default.id
#       containerRegistry = azurerm_container_registry.default.id
#       */
#
#       /*Optional: To enable Customer Managed Keys, the corresponding
#       encryption = {
#         status = var.encryption_status
#         keyVaultProperties = {
#             keyVaultArmId = azurerm_key_vault.default.id
#             keyIdentifier = var.cmk_keyvault_key_uri
#         }
#       }
#       */
#
#     }
#     kind = "hub"
#   })
# }
#
# // Azure AI Project
# resource "azapi_resource" "project" {
#   type      = "Microsoft.MachineLearningServices/workspaces@2024-04-01-preview"
#   name      = "${var.env}-ai-project"
#   location                        = var.region
#   resource_group_name             = var.resource_group_name
#
#   identity {
#     type = "SystemAssigned"
#   }
#
#   body = jsonencode({
#     properties = {
#       description   = "This is my Azure AI PROJECT"
#       friendlyName  = "My Project"
#       hubResourceId = azapi_resource.hub.id
#     }
#     kind = "project"
#   })
# }
#
# // AzAPI AI Services Connection
# resource "azapi_resource" "AIServicesConnection" {
#   type      = "Microsoft.MachineLearningServices/workspaces/connections@2024-04-01-preview"
#   name      = "${var.env}-Default_AIServices"
#   parent_id = azapi_resource.hub.id
#
#   body = jsonencode({
#     properties = {
#       category      = "AIServices",
#       target        = jsondecode(azapi_resource.AIServicesResource.output).properties.endpoint,
#       authType      = "AAD",
#       isSharedToAll = true,
#       metadata = {
#         ApiType    = "Azure",
#         ResourceId = azapi_resource.AIServicesResource.id
#       }
#     }
#   })
#   response_export_values = ["*"]
# }

/* The following resources are OPTIONAL.
// APPLICATION INSIGHTS
resource "azurerm_application_insights" "default" {
  name                = "${var.prefix}appinsights${random_string.suffix.result}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  application_type    = "web"
}

// CONTAINER REGISTRY
resource "azurerm_container_registry" "default" {
  name                     = "${var.prefix}contreg${random_string.suffix.result}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  sku                      = "premium"
  admin_enabled            = true
}
*/