output "vpc_id" {
  value = module.aws_vpc.vpc_default_id
}

output "public_subnet1_id" {
  value = module.aws_vpc.public_subnet1_id
}

output "public_subnet2_id" {
  value = module.aws_vpc.public_subnet2_id
}

output "private_subnet1_id" {
  value = module.aws_vpc.private_subnet1_id
}

output "private_subnet2_id" {
  value = module.aws_vpc.private_subnet2_id
}

output "key_name" {
  value = module.aws_vpc.key_name
}

output "allowed_ips" {
  value = var.AllowedIPs
}

