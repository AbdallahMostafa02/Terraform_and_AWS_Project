output "public_subnet_az1_id" {
  description = "ID of the public subnet in AZ1."
  value       = aws_subnet.public_subnet_az1.id
}

output "public_subnet_az2_id" {
  description = "ID of the public subnet in AZ2."
  value       = aws_subnet.public_subnet_az2.id
}

output "private_subnet_az1_id" {
  description = "ID of the private subnet in AZ1."
  value       = aws_subnet.private_subnet_az1.id
}

output "private_subnet_az2_id" {
  description = "ID of the private subnet in AZ2."
  value       = aws_subnet.private_subnet_az2.id
}
