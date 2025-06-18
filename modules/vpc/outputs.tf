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