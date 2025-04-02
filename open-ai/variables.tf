#module specific
variable "instance_id" {
  description = "Instance number of your resource"
  type        = string
}

# variable "models" {
#   description = <<EOF
#         Map of models to deploy into the openai resource.
#         Key of object in map is not used.
#         - deployment_name: deployment name of the model deployment.
#         - name: name of the model to deploy.
#         - version: version name of the model to deploy, probably 4 digits.
#     EOF
#   type = map(object({
#     deployment_name = string
#     name            = string
#     version         = string
#     capacity        = number
#   }))
# }

variable "resource_name_prefix" {
  description = "Prefix for the resource name"
  default     = "mlops"
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
  default = "rg"
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