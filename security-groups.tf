# Logstash #############################################

resource "aws_security_group" "logstash_sg" {
  name        = "${local.prefix}-Logstash security group"
  description = "Security group for Logstash instances"
  vpc_id      = aws_vpc.calm_vpc.id
  
  tags        = merge({Name = "${local.prefix}-Logstash security group"}, local.common_tags)
}

resource "aws_security_group_rule" "logstash_ssh_ingress_access" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.logstash_sg.id
  cidr_blocks       = [ "0.0.0.0/0" ]
  description       = "Allow ssh access to Logstash instance"
}

resource "aws_security_group_rule" "logstash_beats_ingress" {
  security_group_id = aws_security_group.logstash_sg.id
  type              = "ingress"
  cidr_blocks       = [ "0.0.0.0/0" ]
  protocol          = "tcp"
  from_port         = 5044
  to_port           = 5044
  description       = "Beats 5044 ingress"
}

resource "aws_security_group_rule" "logstash_http_ingress" {
  security_group_id = aws_security_group.logstash_sg.id
  type              = "ingress"
  cidr_blocks       = [ "0.0.0.0/0" ]
  protocol          = "tcp"
  from_port         = 5045
  to_port           = 5045
  description       = "HTTP 5045 ingress"
}

resource "aws_security_group_rule" "logstash_node_exporter_ingress" {
  security_group_id = aws_security_group.logstash_sg.id
  type              = "ingress"
  cidr_blocks       = [ "0.0.0.0/0" ]
  protocol          = "tcp"
  from_port         = 9100
  to_port           = 9100
  description       = "Prometheus node exporter"
}

resource "aws_security_group_rule" "logstash_process_exporter_ingress" {
  security_group_id = aws_security_group.logstash_sg.id
  type              = "ingress"
  cidr_blocks       = [ "0.0.0.0/0" ]
  protocol          = "tcp"
  from_port         = 9256
  to_port           = 9256
  description       = "Prometheus process exporter"
}

resource "aws_security_group_rule" "logstash_egress_access" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  security_group_id = aws_security_group.logstash_sg.id
  cidr_blocks       = [ "0.0.0.0/0" ]
  description       = "Allow all traffic out of SG"
}

# Prometheus ###########################################

resource "aws_security_group" "prometheus_sg" {
  name        = "${local.prefix}-Prometheus security group"
  description = "Security group for Prometheus instances"
  vpc_id      = aws_vpc.calm_vpc.id
  
  tags        = merge({Name = "${local.prefix}-Prometheus security group"}, local.common_tags)
}

resource "aws_security_group_rule" "prometheus_ssh_ingress_access" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.prometheus_sg.id
  cidr_blocks       = [ "0.0.0.0/0" ]
  description       = "Allow ssh access to Prometheus instance"
}

resource "aws_security_group_rule" "prometheus_dashboard_access" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.prometheus_sg.id
  cidr_blocks       = [ "0.0.0.0/0" ]
  description       = "Allow access to Prometheus"
}

resource "aws_security_group_rule" "prometheus_egress_access" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  security_group_id = aws_security_group.prometheus_sg.id
  cidr_blocks       = [ "0.0.0.0/0" ]
  description       = "Allow all traffic out of SG"
}

# Alertmanager ###########################################

resource "aws_security_group" "alertmanager_sg" {
  name        = "${local.prefix}-Alertmanager security group"
  description = "Security group for Alertmanager instances"
  vpc_id      = aws_vpc.calm_vpc.id
  
  tags        = merge({Name = "${local.prefix}-Alertmanager security group"}, local.common_tags)
}

resource "aws_security_group_rule" "alertmanager_ssh_ingress_access" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.alertmanager_sg.id
  cidr_blocks       = [ "0.0.0.0/0" ]
  description       = "Allow ssh access to Alertmanager instance"
}

resource "aws_security_group_rule" "alertmanager_dashboard_access" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.alertmanager_sg.id
  cidr_blocks       = [ "0.0.0.0/0" ]
  description       = "Allow access to Alertmanager"
}

resource "aws_security_group_rule" "alertmanager_node_exporter_ingress" {
  security_group_id = aws_security_group.alertmanager_sg.id
  type              = "ingress"
  cidr_blocks       = [ "0.0.0.0/0" ]
  protocol          = "tcp"
  from_port         = 9100
  to_port           = 9100
  description       = "Prometheus node exporter"
}

resource "aws_security_group_rule" "alertmanager_process_exporter_ingress" {
  security_group_id = aws_security_group.alertmanager_sg.id
  type              = "ingress"
  cidr_blocks       = [ "0.0.0.0/0" ]
  protocol          = "tcp"
  from_port         = 9256
  to_port           = 9256
  description       = "Prometheus process exporter"
}

resource "aws_security_group_rule" "alertmanager_egress_access" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  security_group_id = aws_security_group.alertmanager_sg.id
  cidr_blocks       = [ "0.0.0.0/0" ]
  description       = "Allow all traffic out of SG"
}

# Grafana ###########################################

resource "aws_security_group" "grafana_sg" {
  name        = "${local.prefix}-Grafana security group"
  description = "Security group for Grafana instances"
  vpc_id      = aws_vpc.calm_vpc.id
  
  tags        = merge({Name = "${local.prefix}-Grafana security group"}, local.common_tags)
}

resource "aws_security_group_rule" "grafana_ssh_ingress_access" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.grafana_sg.id
  cidr_blocks       = [ "0.0.0.0/0" ]
  description       = "Allow ssh access to Grafana instance"
}

resource "aws_security_group_rule" "grafana_dashboard_access" {
  type              = "ingress"
  from_port         = 3000
  to_port           = 3000
  protocol          = "tcp"
  security_group_id = aws_security_group.grafana_sg.id
  cidr_blocks       = [ "0.0.0.0/0" ]
  description       = "Allow access to Grafana"
}

resource "aws_security_group_rule" "grafana_node_exporter_ingress" {
  security_group_id = aws_security_group.grafana_sg.id
  type              = "ingress"
  cidr_blocks       = [ "0.0.0.0/0" ]
  protocol          = "tcp"
  from_port         = 9100
  to_port           = 9100
  description       = "Prometheus node exporter"
}

resource "aws_security_group_rule" "grafana_process_exporter_ingress" {
  security_group_id = aws_security_group.grafana_sg.id
  type              = "ingress"
  cidr_blocks       = [ "0.0.0.0/0" ]
  protocol          = "tcp"
  from_port         = 9256
  to_port           = 9256
  description       = "Prometheus process exporter"
}

resource "aws_security_group_rule" "grafana_egress_access" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  security_group_id = aws_security_group.grafana_sg.id
  cidr_blocks       = [ "0.0.0.0/0" ]
  description       = "Allow all traffic out of SG"
}

# Elasticsearch ###########################################

resource "aws_security_group" "elasticsearch_sg" {
  name          = "${local.prefix}-elasticsearch"
  description   = "Security group for elasticsearch"
  vpc_id        = aws_vpc.calm_vpc.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"

    cidr_blocks = [ "0.0.0.0/0" ]
  }

  tags          = merge({Name = "${local.prefix}-elasticsearch security group"}, local.common_tags)
}
