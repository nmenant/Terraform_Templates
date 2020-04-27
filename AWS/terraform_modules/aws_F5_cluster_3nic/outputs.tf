output "f5_bigip1_public_ip" {
  value = aws_instance.f5_bigip1.public_ip
}

output "f5_bigip2_public_ip" {
  value = aws_instance.f5_bigip2.public_ip
}

