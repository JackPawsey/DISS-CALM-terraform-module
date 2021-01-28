locals {
  elasticsearch_configurations = {
    prod = {
      data_instance_type            = "m5.large.elasticsearch"
      elasticsearch_data_node_count = 3
      ebs_enabled                   = true
      encrypt_at_rest               = true
      node_to_node_encryption       = true
      dedicated_master_enabled      = true
      dedicated_master_count        = 3
      dedicated_master_type         = "m5.large.elasticsearch"
    }

    staging = {
      data_instance_type            = "t2.small.elasticsearch"
      elasticsearch_data_node_count = 1
      ebs_enabled                   = true
      volume_size                   = 10
      encrypt_at_rest               = false # t2.small clusters don't support encryption at rest
      node_to_node_encryption       = false # t2.small clusters don't support encryption
      dedicated_master_enabled      = false
    }
  }

  es-name = "${local.prefix}-es"

  selected_es_config = local.elasticsearch_configurations[var.elasticsearch_configuration]
}

resource "aws_elasticsearch_domain" "elasticsearch" {
  domain_name = local.es-name
  
  elasticsearch_version = "7.7"

  cluster_config {
    instance_type            = local.selected_es_config.data_instance_type
    instance_count           = local.selected_es_config.elasticsearch_data_node_count
    dedicated_master_enabled = lookup(local.selected_es_config, "dedicated_master_enabled", null)
    dedicated_master_type    = lookup(local.selected_es_config, "dedicated_master_type", null)
    dedicated_master_count   = lookup(local.selected_es_config, "dedicated_master_count", null)
    zone_awareness_enabled   = local.selected_es_config.elasticsearch_data_node_count > 1

    dynamic "zone_awareness_config" {
      for_each = local.selected_es_config.elasticsearch_data_node_count > 1 ? [1] : []
      content {
        availability_zone_count = local.selected_es_config.elasticsearch_data_node_count == 2 ? 2 : 3
      }
    }
  }

  ebs_options {
    ebs_enabled = local.selected_es_config.ebs_enabled
    volume_size = lookup(local.selected_es_config, "volume_size", null)
  }

  encrypt_at_rest {
    enabled = local.selected_es_config.encrypt_at_rest
  }

  node_to_node_encryption {
    enabled = local.selected_es_config.node_to_node_encryption
  }

  vpc_options {
    #subnet_ids         = aws_subnet.public_subnet.*.id
    subnet_ids         = local.selected_es_config.elasticsearch_data_node_count == 1 ? [aws_subnet.public_subnet[0].id] : aws_subnet.public_subnet[*].id
    security_group_ids = [aws_security_group.elasticsearch_sg.id]
  }

  access_policies = <<CONFIG
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "es:*",
            "Principal": "*",
            "Effect": "Allow",
            "Resource": "arn:aws:es:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:domain/${local.es-name}/*"
        }
    ]
}
CONFIG

  tags = merge({Name = "${local.prefix}-elasticsearch"}, local.common_tags)
}
