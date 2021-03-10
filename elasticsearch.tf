resource "aws_elasticsearch_domain" "elasticsearch" {
  domain_name = "${local.prefix}-elasticsearch"
  
  elasticsearch_version = var.es_version

  cluster_config {
    instance_type            = var.es_data_instance_type
    instance_count           = var.es_data_node_count
    dedicated_master_enabled = var.es_master_count > 1 ? true : false
    dedicated_master_type    = var.es_master_instance_type
    dedicated_master_count   = var.es_master_count
    zone_awareness_enabled   = var.es_data_node_count > 1

    dynamic "zone_awareness_config" {
      for_each = var.es_data_node_count > 1 ? [1] : []
      content {
        availability_zone_count = var.es_data_node_count == 2 ? 2 : 3
      }
    }
  }

  ebs_options {
    ebs_enabled = true
    volume_size = var.ebs_volume_size
  }

  encrypt_at_rest {
    enabled = var.es_rest_encryption
  }

  node_to_node_encryption {
    enabled = var.es_node2node_encryption
  }

  vpc_options {
    subnet_ids         = var.es_data_node_count == 1 ? [aws_subnet.public_subnet[0].id] : aws_subnet.public_subnet[*].id
    security_group_ids = [aws_security_group.elasticsearch_sg.id]
  }

  timeouts {
    update = "2h"
  }

  access_policies = <<CONFIG
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "es:*",
            "Principal": "*",
            "Effect": "Allow",
            "Resource": "arn:aws:es:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:domain/${local.prefix}-elasticsearch/*"
        }
    ]
}
CONFIG

  tags = merge({Name = "${local.prefix}-elasticsearch"}, local.common_tags)
}
