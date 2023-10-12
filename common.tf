locals {
  prefix              = "${var.env}-${var.name}"
  common_tags         = merge({
    environment       = "${var.env}"
    system            = "${var.name}"
    automated         = "True"
  })
}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}