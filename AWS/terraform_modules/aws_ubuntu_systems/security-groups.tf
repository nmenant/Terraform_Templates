resource "aws_security_group" "ubuntu_sg" {
    name = "${var.ubuntu_instance_name}_sg"
    vpc_id = var.vpc_id
    description = "Accept incoming connections."

    ingress {
        from_port       = 80
        to_port         = 80
        protocol        = "tcp"
        cidr_blocks     = var.AllowedIPs
    }

    ingress {
        from_port       = 80
        to_port         = 80
        protocol        = "tcp"
        cidr_blocks     = [var.public_subnet1_cidr, var.public_subnet2_cidr, var.private_subnet1_cidr, var.private_subnet2_cidr] 
    }

    ingress {
        from_port       = 443
        to_port         = 443
        protocol        = "tcp"
        cidr_blocks     = var.AllowedIPs
    }

    ingress {
        from_port       = 443
        to_port         = 443
        protocol        = "tcp"
        cidr_blocks     = [var.public_subnet1_cidr, var.public_subnet2_cidr, var.private_subnet1_cidr, var.private_subnet2_cidr]  
    }

    ingress {
        from_port       = 22
        to_port         = 22
        protocol        = "tcp"
        cidr_blocks     = var.AllowedIPs
    }

    ingress {
        from_port       = 22
        to_port         = 22
        protocol        = "tcp"
        cidr_blocks     = [var.public_subnet1_cidr, var.public_subnet2_cidr, var.private_subnet1_cidr, var.private_subnet2_cidr]  
    }

    ingress {
        from_port       = -1
        to_port         = -1
        protocol        = "icmp"
        cidr_blocks     = var.AllowedIPs
    }

    ingress {
        from_port       = -1
        to_port         = -1
        protocol        = "icmp"
        cidr_blocks     = [var.public_subnet1_cidr, var.public_subnet2_cidr, var.private_subnet1_cidr, var.private_subnet2_cidr]  
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"] 
    }

    tags = {
        Name = "${var.ubuntu_instance_name}_sg"
    }
}