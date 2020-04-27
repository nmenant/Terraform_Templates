output "vpc_id" {
  value = module.aws_vpc.vpc_default_id
}

output "key_name" {
  value = module.aws_vpc.key_name
}

output "ubuntu_public_ips" {
  value = module.aws_ubuntu_systems.ubuntu_public_ips
}

output "ubuntu_private_ips" {
  value = module.aws_ubuntu_systems.ubuntu_private_ips
}

output "f5_bigip1_public_ip" {
  value = module.aws_f5_cluster.f5_bigip1_public_ip
}
output "f5_bigip2_public_ip" {
  value = module.aws_f5_cluster.f5_bigip2_public_ip
}

output "allowed_ips" {
  value = var.AllowedIPs
}

