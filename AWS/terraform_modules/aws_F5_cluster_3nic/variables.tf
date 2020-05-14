variable "vpc_id" {
    type = "string"
}
variable "aws_region" {
  type = "string"
}
variable "f5_mgmt_subnet1_id" {
  type = "string"
}
variable "f5_mgmt_subnet2_id" {
  type = "string"
}
variable "f5_public_subnet1_id" {
  type = "string"
}
variable "f5_public_subnet2_id" {
  type = "string"
}
variable "f5_private_subnet1_id" {
  type = "string"
}
variable "f5_private_subnet2_id" {
  type = "string"
}

variable "mgmt_subnet1_cidr" {
  type = "string"
}
variable "mgmt_subnet2_cidr" {
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
variable "key_name" {
  type = "string"
}
variable "AllowedIPs" {
  type = list(string)
}

variable "f5_name_filter" {
  type = "string"
}

variable "bigip_https_port" {
  type = "string"
}

variable "owner" {
  type = "string"
}

variable libs_dir { 
  default = "/config/cloud/aws" 
}
variable onboard_log { 
  default = "/var/log/startup-script.log" 
}

variable AS3_URL {
  type = "string"
}

variable DO_URL {
  type = "string"
}

variable TS_URL {
  type = "string"
}

variable CFE_URL {
  type = "string"
}

variable "f5_instance_type" {
  type = "string"
}

