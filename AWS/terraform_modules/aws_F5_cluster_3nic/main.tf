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
    CFE_URL         = var.CFE_URL
    libs_dir		    = var.libs_dir
    onboard_log		  = var.onboard_log
  }
}

# 
# Create Management Network Interfaces
#
resource "aws_network_interface" "bigip1-mgmt" {
  subnet_id       = var.f5_mgmt_subnet1_id
  security_groups = [aws_security_group.f5_bigip_sg.id]
}

#
# add an elastic IP to the BIG-IP management interface
#
resource "aws_eip" "bigip1-mgmt" {
  network_interface = aws_network_interface.bigip1-mgmt.id
  vpc               = true
}

resource "aws_network_interface" "bigip2-mgmt" {
  subnet_id       = var.f5_mgmt_subnet2_id
  security_groups = [aws_security_group.f5_bigip_sg.id]
}

#
# add an elastic IP to the BIG-IP management interface
#
resource "aws_eip" "bigip2-mgmt" {
  network_interface = aws_network_interface.bigip2-mgmt.id
  vpc               = true
}

# 
# Create Public Network Interfaces
#
resource "aws_network_interface" "bigip1-public" {
  subnet_id         = var.f5_public_subnet1_id
  security_groups   = [aws_security_group.f5_bigip_sg.id]
}
resource "aws_network_interface" "bigip2-public" {
  subnet_id         = var.f5_public_subnet2_id
  security_groups   = [aws_security_group.f5_bigip_sg.id]
}
# 
# Create Private Network Interfaces
#
resource "aws_network_interface" "bigip1-private" {
  subnet_id       = var.f5_private_subnet1_id
  security_groups = [aws_security_group.f5_bigip_sg.id]
}
resource "aws_network_interface" "bigip2-private" {
  subnet_id       = var.f5_private_subnet2_id
  security_groups = [aws_security_group.f5_bigip_sg.id]
}

#Deploy F5 BIG-IP 3 Nic Standalone
resource "aws_instance" "f5_bigip1" {
  instance_type                 = var.f5_instance_type
  ami                           = data.aws_ami.f5_ami.id
  key_name                      = var.key_name

  network_interface {
    network_interface_id        = aws_network_interface.bigip1-mgmt.id
    device_index                = 0
  }

  network_interface {
    network_interface_id        = aws_network_interface.bigip1-public.id
    device_index                = 1
  }

  network_interface {
    network_interface_id        = aws_network_interface.bigip1-private.id
    device_index                = 2
  }

  root_block_device {
    delete_on_termination       = true
  }

  user_data                     = data.template_file.f5_bigip_onboard.rendered
  depends_on = [aws_eip.bigip1-mgmt]
  tags = {
    Name                        = "${var.owner}-f5_bigip1"
  }
}

#Deploy F5 BIG-IP 3 Nic Standalone
resource "aws_instance" "f5_bigip2" {
  instance_type                 = var.f5_instance_type
  ami                           = data.aws_ami.f5_ami.id
  key_name                      = var.key_name

  network_interface {
    network_interface_id        = aws_network_interface.bigip2-mgmt.id
    device_index                = 0
  }

  network_interface {
    network_interface_id        = aws_network_interface.bigip2-public.id
    device_index                = 1
  }

  network_interface {
    network_interface_id        = aws_network_interface.bigip2-private.id
    device_index                = 2
  }

  root_block_device {
    delete_on_termination       = true
  }
  
  user_data                     = data.template_file.f5_bigip_onboard.rendered
  depends_on = [aws_eip.bigip1-mgmt]
  tags = {
    Name                        = "${var.owner}-f5_bigip2"
  }
}