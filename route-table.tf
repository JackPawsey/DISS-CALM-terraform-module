resource "aws_route_table" "route_table" {
  vpc_id       = aws_vpc.calm_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags         = merge({Name = "${local.prefix}-Route table"}, local.common_tags)
}

resource "aws_route_table_association" "route_table_association" {
  subnet_id      = aws_subnet.public_subnet[0].id
  route_table_id = aws_route_table.route_table.id
}
