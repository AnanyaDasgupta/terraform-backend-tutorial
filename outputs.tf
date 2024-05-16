output "server_sg" {
  value = aws_security_group.server_sg.id
}

output "private_subnet" {
  value = aws_subnet.private_subnet.arn
}
