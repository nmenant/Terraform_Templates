variable "azure_region" {
  type = string
}

variable "azure_rg_cidr" {
    description = "Azure Ressource Group CIDR"
    default = "10.10.0.0/16"
}

variable "mgmt_subnet1_cidr" {
  description = "First mgmt subnet IP range"
  default = "10.10.0.0/24"
}

variable "public_subnet1_cidr" {
  description = "First public subnet IP range"
  default = "10.10.10.0/24"
}

variable "private_subnet1_cidr" {
  description = "First private subnet IP range"
  default = "10.10.20.0/24"
}

variable "owner" {
  type = string
}

