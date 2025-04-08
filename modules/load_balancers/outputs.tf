output "public_lb_dns_name" {
  value = aws_lb.public_alb.dns_name
}

output "private_lb_dns_name" {
  value = aws_lb.private_alb.dns_name
}
