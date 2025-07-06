resource "aws_db_subnet_group" "persistence_group" {
  name       = "formifypersistencelayergroup"
  subnet_ids = var.private_subnet_ids 

  tags = {
    Name     = "Formify persistence layer group"
  }
}

resource "aws_db_instance" "formify" {
  allocated_storage        = 10
  db_name                  = "formify"
  engine                   = var.db_engine
  engine_version           = var.db_engine_version 
  instance_class           = var.db_instance_class
  username                 = var.db_username
  password                 = var.db_password
  skip_final_snapshot      = true
  vpc_security_group_ids   = var.security_group_ids
  db_subnet_group_name     = aws_db_subnet_group.persistence_group.name
  availability_zone        = "${var.aws_region}a"
  port                     = var.db_port 
  depends_on               = [ aws_db_subnet_group.persistence_group ]

  tags                     = {
    Name                   = "Formify"
  }
}