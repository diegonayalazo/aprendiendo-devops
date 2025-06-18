# Resource group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# AKS cluster
resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_cluster_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "dns-${var.aks_cluster_name}"

  kubernetes_version  = var.kubernetes_version

  default_node_pool {
    name       = "default"
    vm_size    = var.node_vm_size
    node_count = var.node_count
    auto_scaling_enabled = true 
    min_count  = 1
    max_count  = 5
  }

  identity {
    type = "SystemAssigned"
  }
  
  #http_application_routing_enabled = true
  

  auto_scaler_profile {
    scan_interval                  = "20s"
    scale_down_delay_after_add    = "10m"
    scale_down_delay_after_failure= "1m"
    #scale_down_unneeded_time      = "5m"
    #scale_down_unready_time       = "5m"
    max_graceful_termination_sec  = 30
    skip_nodes_with_local_storage = false
    #max_empty_bulk_delete         = 100
    #max_total_unready_percentage  = 100
    #ok_total_unready_count        = 1000
    #max_node_provision_time       = "15m"
  }

  linux_profile {
    admin_username = "azureuser"

    ssh_key {
      key_data = file("~/.ssh/id_rsa.pub")
    }
  }

  tags = {
    Environment = "Production"
  }
}
