# Logstash #####################################################################

resource "aws_instance" "logstash_ec2" {
  ami                         = "ami-04d5cc9b88f9d1d39"
  availability_zone           = aws_subnet.public_subnet[0].availability_zone
  subnet_id                   = aws_subnet.public_subnet[0].id
  instance_type               = var.logstash_instance_type
  vpc_security_group_ids      = [aws_security_group.logstash_sg.id]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.ssh_key.key_name
  iam_instance_profile        = aws_iam_instance_profile.logstash.name
  
  depends_on                  = [aws_internet_gateway.internet_gateway]
  
  tags                        = merge({Name = "${local.prefix}-Logstash"}, local.common_tags)
  volume_tags                 = merge({Name = "${local.prefix}-Logstash block storage"}, local.common_tags)
}

resource "aws_ebs_volume" "logstash_block_storage" {
  availability_zone = aws_subnet.public_subnet[0].availability_zone
  size              = 40
  encrypted         = true

  tags              = merge({Name = "${local.prefix}-Logstash block storage"}, local.common_tags)
}

resource "aws_volume_attachment" "logstash_storage_attachment" {
  device_name  = "/dev/sdf"
  volume_id    = aws_ebs_volume.logstash_block_storage.id
  instance_id  = aws_instance.logstash_ec2.id
  force_detach = true
}

# Prometheus ###################################################################

resource "aws_instance" "prometheus_ec2" {
  ami                         = "ami-04d5cc9b88f9d1d39"
  availability_zone           = aws_subnet.public_subnet[0].availability_zone
  subnet_id                   = aws_subnet.public_subnet[0].id
  instance_type               = var.prometheus_instance_type
  vpc_security_group_ids      = [aws_security_group.prometheus_sg.id]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.ssh_key.key_name
  iam_instance_profile        = aws_iam_instance_profile.prometheus.name
  
  depends_on                  = [aws_internet_gateway.internet_gateway]
  
  tags                        = merge({Name = "${local.prefix}-Prometheus"}, local.common_tags)
  volume_tags                 = merge({Name = "${local.prefix}-Prometheus block storage"}, local.common_tags)
}

resource "aws_ebs_volume" "prometheus_block_storage" {
  availability_zone = aws_subnet.public_subnet[0].availability_zone
  size              = 40
  encrypted         = true

  tags              = merge({Name = "${local.prefix}-Prometheus block storage"}, local.common_tags)
}

resource "aws_volume_attachment" "prometheus_storage_attachment" {
  device_name  = "/dev/sdf"
  volume_id    = aws_ebs_volume.prometheus_block_storage.id
  instance_id  = aws_instance.prometheus_ec2.id
  force_detach = true
}

# Alertmanager ###################################################################

resource "aws_instance" "alertmanager_ec2" {
  ami                         = "ami-04d5cc9b88f9d1d39"
  availability_zone           = aws_subnet.public_subnet[0].availability_zone
  subnet_id                   = aws_subnet.public_subnet[0].id
  instance_type               = var.alertmanager_instance_type
  vpc_security_group_ids      = [aws_security_group.alertmanager_sg.id]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.ssh_key.key_name
  
  depends_on                  = [aws_internet_gateway.internet_gateway]
  
  tags                        = merge({Name = "${local.prefix}-Alertmanager"}, local.common_tags)
  volume_tags                 = merge({Name = "${local.prefix}-Alertmanager block storage"}, local.common_tags)
}

resource "aws_ebs_volume" "alertmanager_block_storage" {
  availability_zone = aws_subnet.public_subnet[0].availability_zone
  size              = 40
  encrypted         = true

  tags              = merge({Name = "${local.prefix}-Alertmanager block storage"}, local.common_tags)
}

resource "aws_volume_attachment" "alertmanager_storage_attachment" {
  device_name  = "/dev/sdf"
  volume_id    = aws_ebs_volume.alertmanager_block_storage.id
  instance_id  = aws_instance.alertmanager_ec2.id
  force_detach = true
}

# Grafana ###################################################################

resource "aws_instance" "grafana_ec2" {
  ami                         = "ami-04d5cc9b88f9d1d39"
  availability_zone           = aws_subnet.public_subnet[0].availability_zone
  subnet_id                   = aws_subnet.public_subnet[0].id
  instance_type               = var.grafana_instance_type
  vpc_security_group_ids      = [aws_security_group.grafana_sg.id]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.ssh_key.key_name
  
  depends_on                  = [aws_internet_gateway.internet_gateway]
  
  tags                        = merge({Name = "${local.prefix}-Grafana"}, local.common_tags)
  volume_tags                 = merge({Name = "${local.prefix}-Grafana block storage"}, local.common_tags)
}

resource "aws_ebs_volume" "grafana_block_storage" {
  availability_zone = aws_subnet.public_subnet[0].availability_zone
  size              = 40
  encrypted         = true

  tags              = merge({Name = "${local.prefix}-Grafana block storage"}, local.common_tags)
}

resource "aws_volume_attachment" "grafana_storage_attachment" {
  device_name  = "/dev/sdf"
  volume_id    = aws_ebs_volume.grafana_block_storage.id
  instance_id  = aws_instance.grafana_ec2.id
  force_detach = true
}
