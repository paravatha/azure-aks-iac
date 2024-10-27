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
  kubernetes_version  = var.kube_version

  default_node_pool {
    name            = "default"
    node_count      = var.node_count
    vm_size         = var.node_size
    os_disk_size_gb = var.disk_size
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