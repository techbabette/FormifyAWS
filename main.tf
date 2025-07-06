module "vpc" {
  source                     = "./modules/vpc"
  vpc_region                 = var.project_region
  vpc_cidr                   = var.vpc_cidr
  subnet_public_cidr         = var.subnet_public_cidr
  subnet_private_a_cidr      = var.subnet_private_a_cidr
  subnet_private_b_cidr      = var.subnet_private_b_cidr
  db_port                    = var.db_port 
}

module "database" {
  source                     = "./modules/database"
  aws_region                 = var.project_region
  db_password                = var.db_password
  db_engine                  = var.db_engine
  db_engine_version          = var.db_engine_version 
  db_instance_class          = var.db_instance_class 
  db_username                = var.db_username 
  db_port                    = var.db_port 
  security_group_ids         = [module.vpc.security_group_ingress_database.id, module.vpc.security_group_egress_all.id] 
  private_subnet_ids         = [module.vpc.subnet_private_a.id, module.vpc.subnet_private_b.id] 
}