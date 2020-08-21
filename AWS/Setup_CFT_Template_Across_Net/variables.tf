variable "owner" {}

variable "project_name" {}

variable "key_path" {}

variable "AllowedIPs" {}

variable "aws_region" {}

variable "aws_az1" {}

variable "aws_az2" {}

##
## Description of VPC CIDR and private/public subnets
## Each private/public subnet will be assigned to a different AZ
##
variable "vpc_cidr" {
    description = "AWS VPC CIDR"
    default = "10.10.0.0/16"
}
variable "mgmt_subnet1_cidr" {
  description = "First mgmt subnet IP range"
  default = "10.10.0.0/24"
}

variable "mgmt_subnet2_cidr" {
  description = "2nd mgmt subnet IP range"
  default = "10.10.1.0/24"
}
variable "public_subnet1_cidr" {
  description = "First public subnet IP range"
  default = "10.10.10.0/24"
}

variable "public_subnet2_cidr" {
  description = "2nd public subnet IP range"
  default = "10.10.11.0/24"
}

variable "private_subnet1_cidr" {
  description = "2nd public subnet IP range"
  default = "10.10.20.0/24"
}

variable "private_subnet2_cidr" {
  description = "2nd public subnet IP range"
  default = "10.10.21.0/24"
}

variable "app_tag_value" {}

