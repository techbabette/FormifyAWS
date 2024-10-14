variable "access_key" {
  sensitive = true
}

variable "secret_key" {
  sensitive = true
}

variable "project_region" {
  type = string
  description = "Region that the project will be deployed to"
  default = "eu-north-1"
}

variable "vpc_cidr" {
  type = string
  description = "Starting VPC CIDR"
  default = "10.0.0.0/16"
}

variable "subnet_public_cidr" {
  type = string
  description = "CIDR used for the subnet with the NAT gateway and ALB, internet facing"
  default = "10.0.1.0/24"
}

variable "subnet_private_cidr" {
  type = string
  description = "CIDR used for the subnet with the compute units and AmazonMQ"
  default = "10.0.2.0/24"
}