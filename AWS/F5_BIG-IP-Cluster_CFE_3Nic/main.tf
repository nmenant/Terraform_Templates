provider "aws" {
  region = var.aws_region
}

module "aws_f5_cluster" {
  source                = "../terraform_modules/aws_F5_cluster_3nic"
  aws_region            = var.aws_region
  vpc_id                = module.aws_vpc.vpc_default_id
  f5_mgmt_subnet1_id    = module.aws_vpc.mgmt_subnet1_id
  f5_mgmt_subnet2_id    = module.aws_vpc.mgmt_subnet2_id
  f5_public_subnet1_id  = module.aws_vpc.public_subnet1_id
  f5_public_subnet2_id  = module.aws_vpc.public_subnet2_id
  f5_private_subnet1_id = module.aws_vpc.private_subnet1_id
  f5_private_subnet2_id = module.aws_vpc.private_subnet2_id
  key_name              = module.aws_vpc.key_name
  owner                 = "${var.owner}-${var.project_name}"
  AllowedIPs            = var.AllowedIPs
  AS3_URL               = var.AS3_URL
  DO_URL                = var.DO_URL
  TS_URL                = var.TS_URL
  CFE_URL               = var.CFE_URL
  f5_instance_type      = var.f5_instance_type
  bigip_https_port      = var.bigip_https_port
  f5_name_filter        = var.f5_name_filter
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

module "aws_ubuntu_systems" {
  source                = "../terraform_modules/aws_ubuntu_systems"
  aws_region            = var.aws_region
  owner                 = "${var.owner}-${var.project_name}"
  ubuntu_subnet_id_az1  = module.aws_vpc.private_subnet1_id
  ubuntu_subnet_id_az2  = module.aws_vpc.private_subnet2_id
  public_subnet1_cidr   = module.aws_vpc.public_subnet1_cidr
  public_subnet2_cidr   = module.aws_vpc.public_subnet2_cidr
  private_subnet1_cidr  = module.aws_vpc.private_subnet1_cidr
  private_subnet2_cidr  = module.aws_vpc.private_subnet2_cidr
  key_name              = module.aws_vpc.key_name
  vpc_id                = module.aws_vpc.vpc_default_id
  AllowedIPs            = var.AllowedIPs
  app_tag_value         = var.app_tag_value
  ubuntu_instance_count = var.ubuntu_instance_count
  ubuntu_instance_name  = var.ubuntu_instance_name
}

data "template_file" "as3_declaration" {
  template = file("./templates/as3_declaration.tpl")
  vars = {
    aws_F5_public_ip  = sort(module.aws_f5_cluster.f5_bigip1_public_ips)[1]
    aws_f5_pool_members = join("\",\n\"", module.aws_ubuntu_systems.ubuntu_private_ips)
  }
}

resource "local_file" "as3_declaration_file" {
  content  = data.template_file.as3_declaration.rendered
  filename = "./as3_declaration.json"
}

data "template_file" "do_bigip1_declaration" {
  template = file("./templates/do_bigip1_declaration.tpl")
  vars = {
    aws_f5_public_ip      = sort(module.aws_f5_cluster.f5_bigip1_public_ips)[0]
    aws_f5_public_ip_app1 = sort(module.aws_f5_cluster.f5_bigip1_public_ips)[1]
    aws_f5_private_ip     = sort(module.aws_f5_cluster.f5_bigip1_private_ip)[0]
  }
}

resource "local_file" "do_bigip1_declaration_file" {
  content  = data.template_file.do_bigip1_declaration.rendered
  filename = "./do_bigip1_declaration.json"
}

data "template_file" "do_bigip2_declaration" {
  template = file("./templates/do_bigip2_declaration.tpl")
  vars = {
    aws_f5_public_ip      = sort(module.aws_f5_cluster.f5_bigip2_public_ips)[0]
    aws_f5_private_ip     = sort(module.aws_f5_cluster.f5_bigip2_private_ip)[0]
  }
}

resource "local_file" "do_bigip2_declaration_file" {
  content  = data.template_file.do_bigip2_declaration.rendered
  filename = "./do_bigip2_declaration.json"
}




