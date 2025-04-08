resource "aws_eip" "nat_eip" {
  tags = {
    Name = "my_nat_eip"
  }
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = var.subnet_id

  tags = {
    Name = "my_nat_gw"
  }
}

resource "aws_route_table" "nat_route_table" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "my_nat_route_table"
  }
}

resource "aws_route_table_association" "private_az1" {
  subnet_id      = var.private_subnet_az1_id
  route_table_id = aws_route_table.nat_route_table.id
}

resource "aws_route_table_association" "private_az2" {
  subnet_id      = var.private_subnet_az2_id
  route_table_id = aws_route_table.nat_route_table.id
}
