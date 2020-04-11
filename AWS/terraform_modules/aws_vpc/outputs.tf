
output "vpc_default_id" {
  value = aws_vpc.default.id
}

output "public_subnet1_id" {
  value = aws_subnet.public-subnet1.id
}
output "public_subnet1_cidr" {
  value = var.public_subnet1_cidr
}
output "public_subnet2_id" {
  value = aws_subnet.public-subnet2.id
}
output "public_subnet2_cidr" {
  value = var.public_subnet2_cidr
}
output "private_subnet1_id" {
  value = aws_subnet.private-subnet1.id
}
output "private_subnet1_cidr" {
  value = var.private_subnet1_cidr
}
output "private_subnet2_id" {
  value = aws_subnet.private-subnet2.id
}
output "private_subnet2_cidr" {
  value = var.private_subnet2_cidr
}
output "key_name" {
  value = "${var.owner}-KeyPair"
}