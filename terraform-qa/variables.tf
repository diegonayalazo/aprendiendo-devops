# Variables
variable "ambiente" {
  default = "qa"
}

variable "resource_group_name" {
  default = "rg-app-ventas"
}

variable "aks_cluster_name" {
  default = "aks-ventas"
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