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

variable "subnet_private_a_cidr" {
  type = string
  description = "CIDR used for the subnet with the compute units and AmazonMQ"
  default = "10.0.2.0/24"
}

variable "subnet_private_b_cidr" {
  type = string
  description = "CIDR used for the subnet with the compute units and AmazonMQ"
  default = "10.0.3.0/24"
}

variable "db_port" {
  type = number
  description = "Port that will be accessible on the database security group"
  default = "3306"
}