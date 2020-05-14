output "f5_bigip1_public_ip" {
  value = aws_instance.f5_bigip1.public_ip
}

output "f5_bigip2_public_ip" {
  value = aws_instance.f5_bigip2.public_ip
}

output "f5_bigip1_public_ips" {
  value = aws_network_interface.bigip1-public.private_ips
}

output "f5_bigip2_public_ips" {
  value = aws_network_interface.bigip2-public.private_ips
}

output "f5_bigip1_private_ip" {
  value = aws_network_interface.bigip1-private.private_ips
}

output "f5_bigip2_private_ip" {
  value = aws_network_interface.bigip2-private.private_ips
}