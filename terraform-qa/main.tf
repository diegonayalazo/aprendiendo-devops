module "cluster" {
  source              = "./cluster" #git repo 
  resource_group_name = "rg-${var.resource_group_name}-${var.ambiente}-01"
  location            = "East US"
  aks_cluster_name    = "aks-${var.aks_cluster_name}-${var.ambiente}-01"
  kubernetes_version  = "1.33"
  node_vm_size        = "Standard_D4ds_v4"
  node_count          = 2
}
