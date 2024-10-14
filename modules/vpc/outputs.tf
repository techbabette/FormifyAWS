output "subnet_public" {
  value = aws_subnet.public
  description = "Public subnet object"
}

output "subnet_private" {
  value = aws_subnet.private
  description = "Private subnet object"
}