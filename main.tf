#resource "azurerm_resource_group" "mlops-test-rg" {
#  name     = "${var.prefix}-aks-resources"
#  location = var.location
#  tags     = var.tags
#}
#
#resource "azurerm_virtual_network" "mlops-test-vn" {
#  location            = azurerm_resource_group.mlops-test-rg.location
#  resource_group_name = azurerm_resource_group.mlops-test-rg.name
#  name                = "${var.prefix}-vn"
#  address_space       = ["10.0.0.0/16"]
#  tags     = var.tags
#}
#
#resource "azurerm_subnet" "mlops-test-sn" {
#  resource_group_name  = azurerm_resource_group.mlops-test-rg.name
#  virtual_network_name = azurerm_virtual_network.mlops-test-vn.name
#  name                 = "${var.prefix}-sn"
#  address_prefixes     = ["10.0.0.0/24"]
#}

locals {
  resource_group = {
    name     = var.resource_group_name
    location = var.location
  }
}

resource "azurerm_kubernetes_cluster" "mlops-test-aks" {
  name                = "${var.prefix}-k8s"
  location            = local.resource_group.location
  resource_group_name = local.resource_group.name
  dns_prefix          = "${var.prefix}-k8s"
  kubernetes_version  = "1.28"

  default_node_pool {
    name            = "default"
    node_count      = 1
    vm_size         = "Standard_D2s_v3"
    os_disk_size_gb = 25
  }

  role_based_access_control_enabled = true

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "standard"
  }

  tags = var.tags
}

#module "aks" {
#  source = "../.."
#
#  prefix                    = "prefix-${random_id.prefix.hex}"
#  cluster_name              = "test-cluster"
#  kubernetes_version        = "1.28" # don't specify the patch version!
#  automatic_channel_upgrade = "patch"
#  network_plugin            = "azure"
#  network_policy            = "azure"
#  os_disk_size_gb           = 30
#  sku_tier                  = "Standard"
#  rbac_aad                  = false
#  vnet_subnet_id            = azurerm_subnet.test.id
#}