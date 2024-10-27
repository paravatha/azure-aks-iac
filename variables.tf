variable "location" {
  default = "eastus"
}
variable "prefix" {
  description = "A prefix used for all resources in this example"
  default     = "mlops-test"
}

variable kube_version {
  description = "The version of Kubernetes to use for the AKS cluster"
  default     = "1.30"
}

variable "node_count" {
  description = "The number of nodes in the Kubernetes Node Pool"
  default     = 2
}

variable "node_size" {
  description = "The size of nodes in the Kubernetes Node Pool"
  default     = "Standard_D2s_v3"
}

variable "disk_size" {
  description = "The size of the disk in the Kubernetes Node Pool"
  default     = 30
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
    usage : "mlops-aks",
    env : "test",
  }
}