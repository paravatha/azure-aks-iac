# data "azurerm_resource_group" "current" {
#   name     = "1-beae94bb-playground-sandbox"
# }

data "azurerm_client_config" "current" {
}

// STORAGE ACCOUNT
# resource "azurerm_storage_account" "default" {
#   name                            = "${var.prefix}storage${random_string.suffix.result}"
#   location                        = var.region
#   resource_group_name             = var.resource_group_name
#   account_tier                    = "Standard"
#   account_replication_type        = "GRS"
#   allow_nested_items_to_be_public = false
# }

// KEY VAULT
# resource "azurerm_key_vault" "default" {
#   name                     = "${var.prefix}keyvault${random_string.suffix.result}"
#   location                 = var.region
#   resource_group_name      = var.resource_group_name
#   tenant_id                = data.azurerm_client_config.current.tenant_id
#   sku_name                 = "standard"
#   purge_protection_enabled = false
# }

// AzAPI AIServices
resource "azapi_resource" "AIServicesResource"{
  type = "Microsoft.CognitiveServices/accounts@2024-10-01"
  name = "AIServicesResource${random_string.suffix.result}"
  location = var.region
  parent_id = "/subscriptions/0cfe2870-d256-4119-b0a3-16293ac11bdc/resourceGroups/1-beae94bb-playground-sandbox"

  identity {
    type = "SystemAssigned"
  }

  body = {
    name = "AIServicesResource${random_string.suffix.result}"
    properties = {
      //restore = true
      customSubDomainName = "${random_string.suffix.result}domain"
      apiProperties = {
        statisticsEnabled = false
      }
    }
    kind = "AIServices"
    sku = {
      name = var.sku
    }
  }

  response_export_values = ["*"]
}

// Azure AI Hub
resource "azapi_resource" "hub" {
  type = "Microsoft.MachineLearningServices/workspaces@2024-10-01"
  name = "${var.env}-aihub"
  location = var.region
  parent_id = "/subscriptions/0cfe2870-d256-4119-b0a3-16293ac11bdc/resourceGroups/1-beae94bb-playground-sandbox"

  identity {
    type = "SystemAssigned"
  }

  body = {
    properties = {
      description = "This is my Azure AI hub"
      friendlyName = "My Hub"
    }
    kind = "hub"
  }
}

// Azure AI Project
resource "azapi_resource" "project" {
  type = "Microsoft.MachineLearningServices/workspaces@2024-10-01"
  name = "my-ai-project${random_string.suffix.result}"
  location = var.region
  parent_id = "/subscriptions/0cfe2870-d256-4119-b0a3-16293ac11bdc/resourceGroups/1-beae94bb-playground-sandbox"

  identity {
    type = "SystemAssigned"
  }

  body = {
    properties = {
      description = "This is my Azure AI PROJECT"
      friendlyName = "My Project"
      hubResourceId = azapi_resource.hub.id
    }
    kind = "project"
  }
}

// AzAPI AI Services Connection
resource "azapi_resource" "AIServicesConnection" {
  type = "Microsoft.MachineLearningServices/workspaces/connections@2024-10-01"
  name = "Default_AIServices${random_string.suffix.result}"
  parent_id = azapi_resource.hub.id

  body = {
    properties = {
      category = "AIServices",
      target = azapi_resource.AIServicesResource.output.properties.endpoint,
      authType = "AAD",
      isSharedToAll = true,
      metadata = {
        ApiType = "Azure",
        ResourceId = azapi_resource.AIServicesResource.id
      }
    }
  }
  response_export_values = ["*"]
}