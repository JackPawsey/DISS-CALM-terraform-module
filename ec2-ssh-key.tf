resource "aws_key_pair" "ssh_key" {
  key_name   = "ssh_key"
  public_key = "public ssh key here"
  tags       = merge({Name = "${local.prefix}-EC2 ssh key"}, local.common_tags)
}