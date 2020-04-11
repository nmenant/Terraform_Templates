output "f5_public_ip" {
  value = aws_instance.f5_bigip1.public_ip
}
output "f5_private_ip" {
  value = aws_instance.f5_bigip1.private_ip
}