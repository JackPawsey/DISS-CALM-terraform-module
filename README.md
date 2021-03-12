# Terraform Module

Variables:

- name: Name of deployment
- env: Environment of deployment
- region: Region of deployment
- logstash_instance_type: Type of Logstash EC2 instance - default: "t2.small"
- logstash_storage_size: Size of Logstash EC2 instance disk - default: "10"
- prometheus_instance_type: Type of Prometheus EC2 instance - default: "t2.small"
- prometheus_storage_size: Size of Prometheus EC2 instance disk - default: "10"
- alertmanager_instance_type: Type of Alertmanager EC2 instance - default: "t2.small"
- alertmanager_storage_size: Size of Alertmanager EC2 instance disk - default: "10"
- grafana_instance_type: Type of Grafana EC2 instance - default: "t2.small"
- grafana_storage_size: Size of Grafana EC2 instance disk - default: "10"
- es_version: The version of elasticsearch to use - default: "7.7"
- es_data_instance_type: The size of elasticsearch data nodes - default: "t2.small.elasticsearch"
- es_data_node_count: The number of elasticsearch data nodes - default: "1"
- ebs_volume_size: The disk size of elasticsearch data nodes - default: "10"
- es_master_count: The number of elasticsearch master nodes - default: "0"
- es_master_instance_type: The size of elasticsearch master nodes - default: null
- es_rest_encryption: Whether data is encrypted at rest inside elasticsearch - default: true
- es_node2node_encryption: Whether data is encrypted between nodes inside elasticsearch - default: true
- zone_id: ID of hosted zone to create DNS records in
- vpc_cidr: CIDR block of the VPC
- subnets: A map of availability zones to CIDR blocks, which will be set up as subnets



| Variable Name | Description | Default Value |
| --- | --- | --- |
| name | Name of deployment |  |
| env | Environment of deployment |  |
| region | Region of deployment |  |
| logstash_instance_type | Region of deployment |  |
| logstash_storage_size | Region of deployment |  |
| prometheus_instance_type | Region of deployment |  |
| prometheus_storage_size | Region of deployment |  |
| alertmanager_instance_type | Region of deployment |  |
| alertmanager_storage_size | Region of deployment |  |
| grafana_instance_type | Region of deployment |  |
| grafana_storage_size | Region of deployment |  |
| es_version | Region of deployment |  |
| es_data_instance_type | Region of deployment |  |
| es_data_node_count | Region of deployment |  |
| ebs_volume_size | Region of deployment |  |
| es_master_count | Region of deployment |  |
| es_master_instance_type | Region of deployment |  |
| es_rest_encryption | Region of deployment |  |
| es_node2node_encryption | Region of deployment |  |
| zone_id | Region of deployment |  |
| vpc_cidr | Region of deployment |  |
| subnets | Region of deployment |  |
