resource "aws_vpc" "calm_vpc" {
  cidr_block = var.vpc_cidr
  
  tags       = merge({Name = "${local.prefix}-VPC"}, local.common_tags)
}
