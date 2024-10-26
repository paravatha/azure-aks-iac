variable "location" {
  default = "westus"
}

variable "prefix" {
  description = "A prefix used for all resources in this example"
  default     = "mlops-test"
}

variable "resource_group_name" {
  default = "aa-playground-sandbox"
}

variable "tags" {
  type = map(string)
  default = {
    team : "mlops",
    usage : "mlops-aks",
    env : "test",
  }
}