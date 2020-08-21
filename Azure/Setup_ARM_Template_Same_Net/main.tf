##
## azurerm provides the information to target a specific subscription/appid/tenantid/... 
## fill it if you haven't setup env variables to provide this information
##
##provider "azurerm" {
##    subscription_id = "xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
##    client_id       = "xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
##    client_secret   = "xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
##    tenant_id       = "xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
##}
provider "azurerm" {
  features {}
}

module "azure_ressourcegroup" {
  source       = "../terraform_modules/azure_ressourcegroup"
  owner        = "${var.owner}-${var.project_name}"
  azure_region = var.azure_region
}



