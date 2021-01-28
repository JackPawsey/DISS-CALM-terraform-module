resource "aws_s3_bucket" "log_storage" {
  bucket              = "${local.prefix}-storage"
  force_destroy       = true
  versioning {       
    enabled           = true
  }
  # Enable server-side encryption by default
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  tags                = merge({Name = "${local.prefix}-storage"}, local.common_tags)
}