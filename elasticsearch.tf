#locals {
#  elasticsearch_configurations = {
#    prod = {
#      data_instance_type            = "m5.large.elasticsearch"
#      elasticsearch_data_node_count = 3
#      ebs_enabled                   = true
#      encrypt_at_rest               = true
#      node_to_node_encryption       = true
#      dedicated_master_enabled      = true
#      dedicated_master_count        = 3
#      dedicated_master_type         = "m5.large.elasticsearch"
#    }
#
#    staging = {
#      data_instance_type            = "t2.small.elasticsearch"
#      elasticsearch_data_node_count = 1
#      ebs_enabled                   = true
#      volume_size                   = 10
#      encrypt_at_rest               = false # t2.small clusters don't support encryption at rest
#      node_to_node_encryption       = false # t2.small clusters don't support encryption
#      dedicated_master_enabled      = false
#    }
#  }
#
#  es-name = "${local.prefix}-es"
#
#  selected_es_config = local.elasticsearch_configurations[var.elasticsearch_configuration]
#}

resource "aws_elasticsearch_domain" "elasticsearch" {
  domain_name = "${local.prefix}-elasticsearch"
  
  elasticsearch_version = "7.7"

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
    #subnet_ids         = aws_subnet.public_subnet.*.id
    subnet_ids         = var..es_data_node_count == 1 ? [aws_subnet.public_subnet[0].id] : aws_subnet.public_subnet[*].id
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
