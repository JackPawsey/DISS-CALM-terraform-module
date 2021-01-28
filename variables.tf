variable "name" {
  description = "Name of deployment."
}

variable "env" {
  description = "Environment of deployment."
}

variable "region" {
  description = "Region of deployment."
}

variable "logstash_instance_type" {
  description = "Type of Logstash EC2 instance."
}

variable "prometheus_instance_type" {
  description = "Type of Prometheus EC2 instance."
}

variable "alertmanager_instance_type" {
  description = "Type of Alertmanager EC2 instance."
}

variable "grafana_instance_type" {
  description = "Type of Grafana EC2 instance."
}

variable "elasticsearch_configuration" {
  description = "The elasticsearch configuration to use."
}

variable "zone_id" {
  description = "ID of hosted zone to create DNS records in."
}

variable "vpc_cidr" {
  description = "CIDR block of the VPC."
}

variable "subnets" {
  description = "A map of availability zones to CIDR blocks, which will be set up as subnets."
  type = map
}

#variable "es_days_to_retain" {
#  description = "Days to retain data in ES."
#}
