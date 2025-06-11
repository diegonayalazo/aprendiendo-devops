ssh-keygen -t rsa -b 4096 -f ~/.ssh/azure_key -C "azureuser" -N ""

terraform init
terraform plan
terraform apply -auto-approve

az vm list-ip-addresses --name terraform-vm --resource-group terraform-rg -o table
ssh -i ~/.ssh/azure_key azureuser@<VM_PUBLIC_IP>

ssh-copy-id -i ~/.ssh/azure_key azureuser@<VM_PUBLIC_IP>
