//  Create one public subnet per key in the subnet map.
resource "aws_subnet" "public_subnet" {
  count                   = length(var.subnets)
  vpc_id                  = aws_vpc.calm_vpc.id
  cidr_block              = element(values(var.subnets), count.index)
  availability_zone       = element(keys(var.subnets), count.index)
  depends_on              = [aws_internet_gateway.internet_gateway]
  map_public_ip_on_launch = true

  tags                    = merge({Name = "${local.prefix}-Public subnet"}, local.common_tags)
}
