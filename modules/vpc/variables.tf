variable "vpc_region" {
  type = string
  description = "Region that the VPC will be created in"
}

variable "vpc_cidr" {
  type = string
  description = "Starting VPC CIDR"
}

variable "subnet_public_cidr" {
  type = string
  description = "CIDR used for the subnet with the NAT gateway and ALB, internet facing"
}

variable "subnet_private_cidr" {
  type = string
  description = "CIDR used for the subnet with the compute units and AmazonMQ"
}