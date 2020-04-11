variable "vpc_cidr" {
    description = "AWS VPC CIDR"
    type = "string"
}

variable "public_subnet1_cidr" {
  description = "First public subnet IP range"
  type = "string"
}

variable "public_subnet2_cidr" {
  description = "2nd public subnet IP range"
  type = "string"
}

variable "private_subnet1_cidr" {
  description = "2nd public subnet IP range"
  type = "string"
}

variable "private_subnet2_cidr" {
  description = "2nd public subnet IP range"
  type = "string"
}
variable "aws_region" {
  type = "string"
}
variable "key_path" {
  type = "string"
}
variable "aws_az1" {
  type = "string"
}
variable "aws_az2" {
  type = "string"
}

variable "owner" {
  type = "string"
}

