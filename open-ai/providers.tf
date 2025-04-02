# terraform {
#   required_version = "~> 1.7.5"
#
#   required_providers {
#     azurerm = {
#       source  = "hashicorp/azurerm"
#     }
#     # azure = {
#     #   source  = "hashicorp/azure"
#     # }
#     azapi = {
#       source  = "azure/azapi"
#     }
#     random = {
#       source  = "hashicorp/random"
#     }
#   }
#
#   backend "local" {
#     workspace_dir = "./local"
#   }
# }
#
# provider "azurerm" {
#   resource_provider_registrations = "none"
#   tenant_id                       = var.tenant_id
#   subscription_id                 = var.subscription_id
#   client_id                       = var.client_id
#   client_secret                   = var.client_secret
#   features {
#     resource_group {
#       prevent_deletion_if_contains_resources = false
#     }
#   }
# }
#
#
# provider "random" {
# }
# provider "azapi" {
# }

terraform {
  required_version = ">=1.5"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.2.0, < 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.3.2"
    }
  }
}

provider "azurerm" {
  resource_provider_registrations = "none"
  tenant_id                       = var.tenant_id
  subscription_id                 = var.subscription_id
  client_id                       = var.client_id
  client_secret                   = var.client_secret
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

provider "random" {}
# provider "azapi" {}