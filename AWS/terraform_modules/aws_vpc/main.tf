provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "default" {
  cidr_block            = var.vpc_cidr
  enable_dns_hostnames  = true
  tags = {
    Name                = "${var.owner}-VPC"
  }
}

#Define the mgmt subnets
resource "aws_subnet" "mgmt-subnet1" {
  vpc_id              = aws_vpc.default.id
  cidr_block          = var.mgmt_subnet1_cidr
  availability_zone   = var.aws_az1

  tags = {
    Name              = "${var.owner}-mgmt-subnet1"
  }
}

resource "aws_subnet" "mgmt-subnet2" {
  vpc_id            = aws_vpc.default.id
  cidr_block        = var.mgmt_subnet2_cidr
  availability_zone = var.aws_az2

  tags = {
    Name = "${var.owner}-mgmt-subnet2"
  }
}

#Define the public subnets
resource "aws_subnet" "public-subnet1" {
  vpc_id              = aws_vpc.default.id
  cidr_block          = var.public_subnet1_cidr
  availability_zone   = var.aws_az1

  tags = {
    Name              = "${var.owner}-public-subnet1"
  }
}

resource "aws_subnet" "public-subnet2" {
  vpc_id            = aws_vpc.default.id
  cidr_block        = var.public_subnet2_cidr
  availability_zone = var.aws_az2

  tags = {
    Name = "${var.owner}-public-subnet2"
  }
}
# Define the private subnet
resource "aws_subnet" "private-subnet1" {
  vpc_id            = aws_vpc.default.id
  cidr_block        = var.private_subnet1_cidr
  availability_zone = var.aws_az1

  tags = {
    Name            = "${var.owner}-private-subnet1"
  }
}

# Define the private subnet
resource "aws_subnet" "private-subnet2" {
  vpc_id            = aws_vpc.default.id
  cidr_block        = var.private_subnet2_cidr
  availability_zone = var.aws_az2

  tags = {
    Name            = "${var.owner}-private-subnet2"
  }
}

# Create the Internet Gateway 

resource "aws_internet_gateway" "internet-gw" {
  vpc_id = aws_vpc.default.id
  tags = {
    Name = "${var.owner}-InternetGw"
  }
}
# Get EIP for Both NAT GW

resource "aws_eip" "eip-nat-gw-public1" {

}

resource "aws_eip" "eip-nat-gw-public2" {

}

# Create One NAT GW per Public Subnet

resource "aws_nat_gateway" "nat-gw-public-subnet1" {
  allocation_id = aws_eip.eip-nat-gw-public1.id
  subnet_id = aws_subnet.public-subnet1.id
}

resource "aws_nat_gateway" "nat-gw-public-subnet2" {
  allocation_id = aws_eip.eip-nat-gw-public2.id
  subnet_id = aws_subnet.public-subnet2.id
}

# Create public route table

resource "aws_route_table" "public-route-table" {
  vpc_id        = aws_vpc.default.id
  route {
    cidr_block  = "0.0.0.0/0"
    gateway_id  = aws_internet_gateway.internet-gw.id
  }

  tags = {
    Name        = "${var.owner}-Public-RouteTable"
  }
}

# Assign the public subnets to route table public-route-table 
resource "aws_route_table_association" "public1-rt" {
  subnet_id       = aws_subnet.public-subnet1.id
  route_table_id  = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "public2-rt" {
  subnet_id       = aws_subnet.public-subnet2.id
  route_table_id  = aws_route_table.public-route-table.id
}

# Assign the mgmt subnets to public route table 
resource "aws_route_table_association" "mgmt1-rt" {
  subnet_id       = aws_subnet.mgmt-subnet1.id
  route_table_id  = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "mgmt2-rt" {
  subnet_id       = aws_subnet.mgmt-subnet2.id
  route_table_id  = aws_route_table.public-route-table.id
}

# Create private route table for private subnet1 using the nat gw 1 as default route

resource "aws_route_table" "private-route-table1" {
  vpc_id        = aws_vpc.default.id
  route {
    cidr_block  = "0.0.0.0/0"
    gateway_id  = aws_nat_gateway.nat-gw-public-subnet1.id
  }

  tags = {
    Name        = "${var.owner}-Private-RouteTable1"
  }
}

# Create private route table for private subnet2 using the nat gw 1 as default route

resource "aws_route_table" "private-route-table2" {
  vpc_id        = aws_vpc.default.id
  route {
    cidr_block  = "0.0.0.0/0"
    gateway_id  = aws_nat_gateway.nat-gw-public-subnet2.id
  }

  tags = {
    Name        = "${var.owner}-Private-RouteTable2"
  }
}
# Assign the private subnet1 to route table private-route-table1
resource "aws_route_table_association" "private1-rt" {
  subnet_id       = aws_subnet.private-subnet1.id
  route_table_id  = aws_route_table.private-route-table1.id
}

# Assign the private subnet2 to route table private-route-table2

resource "aws_route_table_association" "private2-rt" {
  subnet_id       = aws_subnet.private-subnet2.id
  route_table_id  = aws_route_table.private-route-table2.id
}

resource "aws_key_pair" "default" {
  key_name        = "${var.owner}-KeyPair"
  public_key      = file(pathexpand(var.key_path))
}