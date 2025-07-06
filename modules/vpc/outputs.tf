output "subnet_public" {
  value = aws_subnet.public
  description = "Public subnet object"
}

output "subnet_private_a" {
  value = aws_subnet.private_a
  description = "Private subnet A object"
}

output "subnet_private_b" {
  value = aws_subnet.private_b
  description = "Private subnet B object"
}

output "security_group_ingress_database" {
  value = aws_security_group.private_database
  description = "Security group to be associated with the database"
}

output "security_group_egress_all" {
  value = aws_security_group.egress_all
  description = "Security group to allow all outbound traffic"
}