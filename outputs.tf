output "env" {
  value       = var.env
  description = "The deployment environment"
}

output "logstash_instance_id" {
  value       = aws_instance.logstash_ec2.id
  description = "Logstash instance ID"
}

output "logstash_instance_ip" {
  value       = aws_instance.logstash_ec2.public_ip
  description = "Logstash instance IP"
}

output "prometheus_instance_id" {
  value       = aws_instance.prometheus_ec2.id
  description = "Prometheus instance ID"
}

output "prometheus_instance_ip" {
  value       = aws_instance.prometheus_ec2.public_ip
  description = "Prometheus instance IP"
}

output "alertmanager_instance_id" {
  value       = aws_instance.alertmanager_ec2.id
  description = "Alertmanager instance ID"
}

output "alertmanager_instance_ip" {
  value       = aws_instance.alertmanager_ec2.public_ip
  description = "Alertmanager instance IP"
}

output "grafana_instance_id" {
  value       = aws_instance.grafana_ec2.id
  description = "Grafana instance ID"
}

output "grafana_instance_ip" {
  value       = aws_instance.grafana_ec2.public_ip
  description = "Grafana instance IP"
}

output "s3_bucket_name" {
  value       = aws_s3_bucket.log_storage.id
  description = "The name of the S3 bucket"
}

output "elasticsearch_endpoint" {
  value       = aws_elasticsearch_domain.elasticsearch.endpoint
  description = "The elasticsearch endpoint"
}
