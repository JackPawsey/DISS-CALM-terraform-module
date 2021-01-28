resource "aws_iam_instance_profile" "logstash" {
  name = "${local.prefix}-logstash-instance-profile"
  role = aws_iam_role.logstash.name
}

resource "aws_iam_role" "logstash" {
  name               = "${local.prefix}-logstash-role"
  assume_role_policy = data.aws_iam_policy_document.trust_relationship.json
  
  tags               = merge({Name = "${local.prefix}-logstash-role"}, local.common_tags)
}

data "aws_iam_policy_document" "trust_relationship" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com", "es.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role_policy" "write_to_s3" {
  role   = aws_iam_role.logstash.name
  name   = "write_to_s3"
  policy = data.aws_iam_policy_document.write_to_s3.json
}

data "aws_iam_policy_document" "write_to_s3" {
  statement {
    actions   = ["s3:*"]
    resources = ["arn:aws:s3:::*"]
  }
}

resource "aws_iam_role_policy" "write_to_elasticsearch" {
  role   = aws_iam_role.logstash.name
  name   = "write_to_elasticsearch"
  policy = data.aws_iam_policy_document.write_to_elasticsearch.json
}

data "aws_iam_policy_document" "write_to_elasticsearch" {
  statement {
    actions = [
      "es:ESHttpPost",
      "es:ESHttpPut"
    ]
    resources = ["${aws_elasticsearch_domain.elasticsearch.arn}/*"]
  }
  statement { # Needed for Logstash to perform a healthcheck on the cluster before emiting logs
    actions = [
      "es:ESHttpGet",
      "es:ESHttpHead"
    ]
    resources = [
      "${aws_elasticsearch_domain.elasticsearch.arn}/",
      "${aws_elasticsearch_domain.elasticsearch.arn}/_template/*"
    ]
  }
}

# Prometheus #########################################################

resource "aws_iam_instance_profile" "prometheus" {
  name = "${local.prefix}-prometheus-instance-profile"
  role = aws_iam_role.prometheus.name
}

resource "aws_iam_role" "prometheus" {
  name               = "${local.prefix}-prometheus-role"
  assume_role_policy = data.aws_iam_policy_document.trust_relationship.json
  
  tags               = merge({Name = "${local.prefix}-prometheus-role"}, local.common_tags)
}

# Prometheus EC2 service discovery
resource "aws_iam_role_policy_attachment" "prometheus-server-role-ec2-read-only" {
  role = aws_iam_role.prometheus.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}
