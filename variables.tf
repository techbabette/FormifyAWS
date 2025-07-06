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

variable "db_instance_class" {
  type              = string
  description       = "Database instance class" 
  default           = "db.t3.micro"
}

variable "db_engine" {
    type            = string
    description     = "Database engine type"
    default         = "mysql"
}

variable "db_engine_version" {
    type            = string
    description     = "Database engine version"
    default         = "8.0"
}

variable "db_password" {
    type            = string
    description     = "Database password" 
}

variable "db_username" {
    type            = string
    description     = "Database username" 
    default         = "root"
}

variable "db_port" {
  type              = number
  description       = "Port that will be accessible on the database security group"
  default           = "3306"
}