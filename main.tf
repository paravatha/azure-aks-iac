resource "azurerm_kubernetes_cluster" "mlops-test-aks" {
  name                = "${var.prefix}-k8s"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "${var.prefix}-k8s"
  kubernetes_version  = var.kube_version

  default_node_pool {
    name            = "default"
    node_count      = var.node_count
    vm_size         = var.node_size
    os_disk_size_gb = var.disk_size
  }

  role_based_access_control_enabled = true
  oidc_issuer_enabled       = true
  workload_identity_enabled = true

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "standard"
  }

  service_mesh_profile {
    mode                             = "Istio"
    revisions                        = [var.istio_version]
    external_ingress_gateway_enabled = true
    internal_ingress_gateway_enabled = true
  }

  workload_autoscaler_profile {
    vertical_pod_autoscaler_enabled = true
  }

  tags = var.tags
}
