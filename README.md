# Terraform Module

## Variables:

| Variable Name | Description | Default Value |
| --- | --- | --- |
| name | Name of deployment |  |
| env | Environment of deployment |  |
| region | Region of deployment |  |
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
| zone_id | ID of hosted zone to create DNS records in |  |
| vpc_cidr | CIDR block of the VPC |  |
| subnets | A map of availability zones to CIDR blocks, which will be set up as subnets |  |
