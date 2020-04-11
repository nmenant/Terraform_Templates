provider "aws" {
  region = var.aws_region
}

#Get the most recent AMI for F5
data "aws_ami" "f5_ami" {
  most_recent = true
  owners      = ["679593333241"]

  filter {
    name   = "name"
    values = [var.f5_name_filter]
  }
}

# Data resource to create the user_data script
data "template_file" "f5_bigip_onboard" {
  template = file("./templates/f5_onboard.tpl")

  vars = {
    DO_URL          = var.DO_URL
    AS3_URL		      = var.AS3_URL
    TS_URL          = var.TS_URL
    libs_dir		    = var.libs_dir
    onboard_log		  = var.onboard_log
  }
}

#Deploy F5 BIG-IP 1 Nic Standalone
resource "aws_instance" "f5_bigip1" {
  instance_type                 = var.f5_instance_type
  ami                           = data.aws_ami.f5_ami.id

  
  associate_public_ip_address   = true
  key_name                      = var.key_name
  vpc_security_group_ids        = [aws_security_group.f5_bigip_sg.id]
  subnet_id                     = var.f5_subnet1_id

  root_block_device {
    delete_on_termination       = true
  }
  user_data                     = data.template_file.f5_bigip_onboard.rendered
  tags = {
    Name                        = "${var.owner}-f5_bigip1"
  }
}