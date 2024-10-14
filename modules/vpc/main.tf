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

resource "aws_subnet" "private" {
  vpc_id                 = aws_vpc.main.id
  cidr_block             = var.subnet_private_cidr
  availability_zone      = "${var.vpc_region}a"
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

resource "aws_route_table_association" "private" {
  subnet_id            = aws_subnet.private.id
  route_table_id       = aws_route_table.private.id
}