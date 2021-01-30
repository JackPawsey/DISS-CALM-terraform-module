terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  region  = var.region
  #version = "~> 2.67.0"
  version = "~> 3.24.0"
}
