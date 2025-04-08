output "route_table_id" {
  description = "The ID of the route table."
  value       = aws_route_table.my_route_table.id
}
