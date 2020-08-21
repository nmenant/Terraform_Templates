output "azure_rg_name" {
  value = module.azure_ressourcegroup.azure_rg_name
}

output "allowed_ips" {
  value = var.AllowedIPs
}

output "mgmt_subnet_name" {
  value = module.azure_ressourcegroup.mgmt_subnet1_name
}

output "mgmt_subnet_id" {
  value = module.azure_ressourcegroup.mgmt_subnet1_id
}

output "mgmt_subnet_cidr" {
  value = module.azure_ressourcegroup.mgmt_subnet1_cidr
}

output "public_subnet_name" {
  value = module.azure_ressourcegroup.public_subnet1_name
}

output "public_subnet_id" {
  value = module.azure_ressourcegroup.public_subnet1_id
}

output "public_subnet_cidr" {
  value = module.azure_ressourcegroup.public_subnet1_cidr
}

output "private_subnet_name" {
  value = module.azure_ressourcegroup.private_subnet1_name
}

output "private_subnet_id" {
  value = module.azure_ressourcegroup.private_subnet1_id
}

output "private_subnet_cidr" {
  value = module.azure_ressourcegroup.private_subnet1_cidr
}