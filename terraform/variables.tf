
# Variables
variable "resource_group_name" {
  default = "rg-app-ventas-02"
}

variable "aks_cluster_name" {
  default = "aks-ventas-02"
}

variable "location" {
  default = "eastus"
}

variable "kubernetes_version" {
  default = "1.33.0" 
}

variable "node_vm_size" {
  default = "Standard_D4ds_v4"
}

variable "node_count" {
  default = 1
}