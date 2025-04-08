output "public_ec2_az1_id" {
  value = aws_instance.public_ec2_az1.id
}

output "public_ec2_az2_id" {
  value = aws_instance.public_ec2_az2.id
}

output "private_ec2_az1_id" {
  value = aws_instance.private_ec2_az1.id
}

output "private_ec2_az2_id" {
  value = aws_instance.private_ec2_az2.id
}

output "public_ec2_az1_public_ip" {
  value = aws_instance.public_ec2_az1.public_ip
}
