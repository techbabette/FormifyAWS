variable "aws_region" {
    type            = string
    description     = "AWS Region"
}

variable "private_subnet_ids" {
  type              = list(string)
  description       = "Subnets with which to create a database subnet group"
}

variable "security_group_ids" {
    type            = list(string)
    description     = "Security group ID to associate with the database"
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