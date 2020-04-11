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

resource "aws_internet_gateway" "internet-gw" {
  vpc_id = aws_vpc.default.id
  tags = {
    Name = "${var.owner}-InternetGw"
  }
}

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

# Assign the route table to the public Subnets
resource "aws_route_table_association" "public1-rt" {
  subnet_id       = aws_subnet.public-subnet1.id
  route_table_id  = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "public2-rt" {
  subnet_id       = aws_subnet.public-subnet2.id
  route_table_id  = aws_route_table.public-route-table.id
}

# Assign the route table to the private Subnets
resource "aws_route_table_association" "private1-rt" {
  subnet_id       = aws_subnet.private-subnet1.id
  route_table_id  = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "private2-rt" {
  subnet_id       = aws_subnet.private-subnet2.id
  route_table_id  = aws_route_table.public-route-table.id
}

resource "aws_key_pair" "default" {
  key_name        = "${var.owner}-KeyPair"
  public_key      = file(pathexpand(var.key_path))
}