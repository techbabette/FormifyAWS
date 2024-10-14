module "vpc" {
  source                     = "./modules/vpc"
  vpc_region                 = var.project_region
  vpc_cidr                   = var.vpc_cidr
  subnet_public_cidr         = var.subnet_public_cidr
  subnet_private_cidr        = var.subnet_private_cidr
}