

variable "ubuntu_instance_name" {
    type = "string"
}

variable "ubuntu_instance_count" {
  type = "string"
}

variable "aws_region" {
  type = "string"
}
variable "ubuntu_subnet_id_az1" {
  type = "string"
}
variable "ubuntu_subnet_id_az2" {
  type = "string"
}
variable "key_name" {
  type = "string"
}
variable "vpc_id" {
  type = "string"
}
variable "AllowedIPs" {
  type = list(string)
}

variable "owner" {
  type = "string"
}

variable "public_subnet1_cidr" {
  type = "string"
}
variable "public_subnet2_cidr" {
  type = "string"
}
variable "private_subnet1_cidr" {
  type = "string"
}
variable "private_subnet2_cidr" {
  type = "string"
}

variable "app_tag_value" {
  type = "string"
}