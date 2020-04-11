provider "aws" {
  region = var.aws_region
}

data "aws_ami" "latest-ubuntu" {
most_recent   = true
owners        = ["099720109477"] # Canonical

  filter {
      name    = "name"
      values  = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
      name    = "virtualization-type"
      values  = ["hvm"]
  }
}

resource "aws_instance" "ubuntu_instance_az1" {
  count                         = var.ubuntu_instance_count
  ami                           = data.aws_ami.latest-ubuntu.id
  subnet_id                     = var.ubuntu_subnet_id_az1
  key_name                      = var.key_name
  instance_type = "t2.micro"
  associate_public_ip_address   = true
  vpc_security_group_ids        = [aws_security_group.ubuntu_sg.id]
  tags = {
    Name                        = "${var.owner}-${var.ubuntu_instance_name}-az1-${format("%02d", count.index+1)}"
    Environmnent                = var.owner
    Application                 = var.app_tag_value
  }
}

resource "aws_instance" "ubuntu_instance_az2" {
  count                         = var.ubuntu_instance_count
  ami                           = data.aws_ami.latest-ubuntu.id
  subnet_id                     = var.ubuntu_subnet_id_az2
  key_name                      = var.key_name
  instance_type                 = "t2.micro"
  associate_public_ip_address   = true
  vpc_security_group_ids        = [aws_security_group.ubuntu_sg.id]
  tags = {
    Name                        = "${var.owner}-${var.ubuntu_instance_name}-az2-${format("%02d", count.index+1)}"
    Environmnent                = var.owner
    Application                 = var.app_tag_value
  }
}
