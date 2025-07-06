terraform {
  required_version = ">= 1.9.7"
}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
}

resource "aws_subnet" "public" {
  vpc_id                 = aws_vpc.main.id
  cidr_block             = var.subnet_public_cidr
  availability_zone      = "${var.vpc_region}a"
  map_public_ip_on_launch= true
}

resource "aws_subnet" "private_a" {
  vpc_id                 = aws_vpc.main.id
  cidr_block             = var.subnet_private_a_cidr
  availability_zone      = "${var.vpc_region}a"
}

resource "aws_subnet" "private_b" {
  vpc_id                 = aws_vpc.main.id
  cidr_block             = var.subnet_private_b_cidr
  availability_zone      = "${var.vpc_region}b"
}

# Gateways

resource "aws_internet_gateway" "igw" {
  vpc_id                 = aws_vpc.main.id
}

resource "aws_eip" "ngw_eip" {
  domain                = "vpc"
  depends_on            = [ aws_internet_gateway.igw ]
}

resource "aws_nat_gateway" "ngw" {
  allocation_id        = aws_eip.ngw_eip.id
  subnet_id            = aws_subnet.public.id

  connectivity_type    = "public"

  depends_on           = [ aws_internet_gateway.igw ]
}


#Route tables

resource "aws_route_table" "public" {
  vpc_id               = aws_vpc.main.id

  route {
    cidr_block         = "0.0.0.0/0"
    gateway_id         = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table" "private" {
  vpc_id               = aws_vpc.main.id

  route {
    cidr_block         = "0.0.0.0/0"
    gateway_id         = aws_nat_gateway.ngw.id
  }
}

resource "aws_route_table_association" "public" {
  subnet_id            = aws_subnet.public.id
  route_table_id       = aws_route_table.public.id
}

resource "aws_route_table_association" "private_a" {
  subnet_id            = aws_subnet.private_a.id
  route_table_id       = aws_route_table.private.id
}

resource "aws_route_table_association" "private_b" {
  subnet_id            = aws_subnet.private_b.id
  route_table_id       = aws_route_table.private.id
}

# Security groups

resource "aws_security_group" "private_database" {
  name                = "formify_database"
  description         = "Allow inbound traffic to database port"
  vpc_id              = aws_vpc.main.id

  tags = {
    Name              = "formify_database"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_private_database" {
  security_group_id = aws_security_group.private_database.id
  cidr_ipv4         = aws_vpc.main.cidr_block
  from_port         = var.db_port
  ip_protocol       = "tcp"
  to_port           = var.db_port 
}

resource "aws_security_group" "egress_all" {
  name                = "formify_egress"
  description         = "Allow all outbound traffic"
  vpc_id              = aws_vpc.main.id

  tags = {
    Name              = "formify_egress"
  }
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4_database" {
  security_group_id = aws_security_group.egress_all.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
