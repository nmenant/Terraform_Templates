
output "ubuntu_public_ips" {
  value = concat(aws_instance.ubuntu_instance_az1[*].public_ip, aws_instance.ubuntu_instance_az2[*].public_ip)
}


output "ubuntu_private_ips" {
  value = concat(aws_instance.ubuntu_instance_az1[*].private_ip, aws_instance.ubuntu_instance_az2[*].private_ip)
}
