output "instances_sg_id" {
  value = aws_security_group.instances_security_group.id
}

output "lb_sg_id" {
  value = aws_security_group.lb_sg.id
}
