variable "aws_region" {
    type            = string
    description     = "AWS Region"
}

variable "private_subnet_ids" {
  type = list(number)
  description = "Subnets with which to create a database subnet group"
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