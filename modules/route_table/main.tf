resource "aws_route_table" "my_route_table" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.internet_gateway_id
  }

  tags = {
    Name = "My_Route_Table"
  }
}

resource "aws_route_table_association" "public_az1" {
  subnet_id      = var.public_subnet_az1_id
  route_table_id = aws_route_table.my_route_table.id
}

resource "aws_route_table_association" "public_az2" {
  subnet_id      = var.public_subnet_az2_id
  route_table_id = aws_route_table.my_route_table.id
}
