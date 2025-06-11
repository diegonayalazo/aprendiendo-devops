variable "location" {
  default = "East US"
}

variable "resource_group_name" {
  default = "terraform-rg"
}

variable "vm_name" {
  default = "keypairs-vm"
}

variable "admin_username" {
  default = "azureuser"
}

variable "ssh_public_key_path" {
  description = "Path to the public SSH key"
  type        = string
}
