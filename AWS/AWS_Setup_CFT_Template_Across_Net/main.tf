provider "aws" {
  region = var.aws_region
}

module "aws_vpc" {
  source                = "../terraform_modules/aws_vpc"
  owner                 = "${var.owner}-${var.project_name}"
  aws_region            = var.aws_region
  key_path              = var.key_path
  aws_az1               = var.aws_az1
  aws_az2               = var.aws_az2
  vpc_cidr              = var.vpc_cidr
  mgmt_subnet1_cidr     = var.mgmt_subnet1_cidr
  mgmt_subnet2_cidr     = var.mgmt_subnet2_cidr
  public_subnet1_cidr   = var.public_subnet1_cidr
  public_subnet2_cidr   = var.public_subnet2_cidr
  private_subnet1_cidr  = var.private_subnet1_cidr
  private_subnet2_cidr  = var.private_subnet2_cidr
}
