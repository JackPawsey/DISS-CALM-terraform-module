resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.calm_vpc.id

  tags   = merge({Name = "${local.prefix}-internet gateway"}, local.common_tags)
}
