provider "azurerm" {
  version = "~>2.0"
  features {}
}

variable "rbac_enabled" {
  type = boolean
  default = false
}

resource "azurerm_resource_group" "k8s" {
  name     = "my-kubernetes-cluster"
  location = "Central US"
}

resource "random_id" "log_analytics_workspace_name_suffix" {
  byte_length = 8
}

resource "azurerm_log_analytics_workspace" "test" {
  # The WorkSpace name has to be unique across the whole of azure, not just the current subscription/tenant.
  name                = "${var.log_analytics_workspace_name}-${random_id.log_analytics_workspace_name_suffix.dec}"
  location            = "eastus"
  resource_group_name = azurerm_resource_group.k8s.name
  sku                 = "PerGB2018"
}

resource "azurerm_log_analytics_solution" "test" {
  solution_name         = "ContainerInsights"
  location              = azurerm_log_analytics_workspace.test.location
  resource_group_name   = azurerm_resource_group.k8s.name
  workspace_resource_id = azurerm_log_analytics_workspace.test.id
  workspace_name        = azurerm_log_analytics_workspace.test.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/ContainerInsights"
  }
}

resource "azurerm_kubernetes_cluster" "k8s" {
  name                            = "kubernetes-production"
  location                        = azurerm_resource_group.k8s.location
  resource_group_name             = azurerm_resource_group.k8s.name
  dns_prefix                      = "k8stest"
  api_server_authorized_ip_ranges = ["0.0.0.0/0"]

  role_based_access_control {
    enabled = var.rbac_enabled
  }


  linux_profile {
    admin_username = "ubuntu"

    ssh_key {
      key_data = file(var.ssh_public_key)
    }
  }

  default_node_pool {
    name       = "agentpool"
    node_count = 3
    vm_size    = "Standard_D2_v2"
  }

  service_principal {
    client_id     = var.client_id
    client_secret = var.client_secret
  }

  addon_profile {
    oms_agent {
      enabled = false
    }
  }

  network_profile {
    load_balancer_sku = "Standard"
    network_plugin    = "kubenet"
  }

  tags = {
    Environment = "Production"
  }
}
