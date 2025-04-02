variable "resource_group_location" {
  type        = string
  default     = "eastus"
  description = "Location of the resource group."
}

variable "resource_group_name_prefix" {
  type        = string
  default     = "rg"
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}

variable "prefix" {
  type = string
  description="This variable is used to name the hub, project, and dependent resources."
  default = "ai"
}

variable "sku" {
  type        = string
  description = "The sku name of the Azure Analysis Services server to create. Choose from: B1, B2, D1, S0, S1, S2, S3, S4, S8, S9. Some skus are region specific. See https://docs.microsoft.com/en-us/azure/analysis-services/analysis-services-overview#availability-by-region"
  default     = "S0"
}

resource "random_string" "suffix" {
  length           = 4
  special          = false
  upper            = false
}

variable "region" {
  description = "Region of the resource"
  default     = "eastus"
}

variable "env" {
  description = "Environment of the resource"
  default     = "dev"
}

variable "tenant_id" {
  description = "The Tenant ID for the Azure subscription"
  default     = "ttt"
}

variable "subscription_id" {
  description = "The Subscription ID for the Azure subscription"
  default     = "sss"
}

variable "resource_group_name" {
  default = "1-beae94bb-playground-sandbox"
}

variable "client_id" {
  default = "ccc"
}

variable "client_secret" {
  default = "ccc"
}
variable "tags" {
  type = map(string)
  default = {
    team : "mlops",
    usage : "mlops-ai",
    env : "dev",
  }
}