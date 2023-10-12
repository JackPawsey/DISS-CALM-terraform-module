# DISS-CALM-terraform-module
Final year uni dissertation

Terraform module to create CALM stack within an AWS account

## About
Sets up network with VPC, subnets, route tables and internet gateway  
Provisions four EC2 instances with DNS names and an AWS managed Elasticsearch cluster

## Variables
| Variable Name | Description | Default Value |
| --- | --- | --- |
| name | Name of deployment | **required** |
| env | Environment of deployment | **required** |
| region | Region of deployment | **required** |
| zone_id | ID of hosted zone to create DNS records in | **required** |
| vpc_cidr | CIDR block of the VPC | **required** |
| subnets | A map of availability zones to CIDR blocks, which will be set up as subnets | **required** |
| logstash_instance_type | Type of Logstash EC2 instance | "t2.small" |
| logstash_storage_size | Size of Logstash EC2 instance disk | "10" |
| prometheus_instance_type | Type of Prometheus EC2 instance | "t2.small" |
| prometheus_storage_size | Size of Prometheus EC2 instance disk | "10" |
| alertmanager_instance_type | Type of Alertmanager EC2 instance | "t2.small" |
| alertmanager_storage_size | Size of Alertmanager EC2 instance disk | "10" |
| grafana_instance_type | Type of Grafana EC2 instance | "t2.small" |
| grafana_storage_size | Size of Grafana EC2 instance disk | "10" |
| es_version |The version of elasticsearch to use | "7.7" |
| es_data_instance_type | The size of elasticsearch data nodes | "t2.small.elasticsearch" |
| es_data_node_count | The number of elasticsearch data nodes | "1" |
| ebs_volume_size | The disk size of elasticsearch data nodes | "10" |
| es_master_count | The number of elasticsearch master nodes | "0" |
| es_master_instance_type | The size of elasticsearch master nodes | null |
| es_rest_encryption | Whether data is encrypted at rest inside elasticsearch | true |
| es_node2node_encryption | Whether data is encrypted between nodes inside elasticsearch | true |

## Resources
- aws_vpc
- aws_subnet
- aws_security_group
- aws_security_group_rule
- aws_s3_bucket
- aws_route53_record
- aws_route_table
- aws_route_table_association
- aws_internet_gateway
- aws_iam_instance_profile
- aws_iam_role
- aws_iam_policy_document
- aws_iam_role_policy_attachment
- aws_iam_role_policy
- aws_elasticsearch_domain
- aws_instance
- aws_ebs_volume
- aws_volume_attachment
- aws_key_pair
