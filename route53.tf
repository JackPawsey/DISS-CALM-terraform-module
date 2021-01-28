resource "aws_route53_record" "prometheus" {
  zone_id = var.zone_id
  name    = "prometheus-${var.env}"
  type    = "A"
  ttl     = 30
  records = [aws_instance.prometheus_ec2.public_ip]
}

resource "aws_route53_record" "logstash" {
  zone_id = var.zone_id
  name    = "logstash-${var.env}"
  type    = "A"
  ttl     = 30
  records = [aws_instance.logstash_ec2.public_ip]
}

resource "aws_route53_record" "grafana" {
  zone_id = var.zone_id
  name    = "grafana-${var.env}"
  type    = "A"
  ttl     = 30
  records = [aws_instance.grafana_ec2.public_ip]
}

resource "aws_route53_record" "alertmanager" {
  zone_id = var.zone_id
  name    = "alertmanager-${var.env}"
  type    = "A"
  ttl     = 30
  records = [aws_instance.alertmanager_ec2.public_ip]
}