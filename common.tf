locals {
  prefix              = "${var.env}-${var.name}"
  common_tags         = merge({
    environment       = "${var.env}"
    system            = "${var.name}"
    automated         = "True"
    maintainer_email  = "jfrewer@live.co.uk"
  })
}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}