data "aws_region" "current" {}

data "aws_ami" "search" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "is-public"
    values = ["true"]
  }
  name_regex = "${lookup("${var.amis_os_map_regex}", "${var.platform}")}"
}

resource "aws_instance" "instance" {
  count                  = var.instance_count
  ami                    = "${data.aws_ami.search.id}"
  instance_type          = var.instance_type
  vpc_security_group_ids = var.security_group_ids
  subnet_id              = element(var.subnet_ids, count.index)
  key_name               = aws_key_pair.instance.key_name
  monitoring             = var.enable_monitoring
  user_data              = var.user_data
  root_block_device {
    volume_type = "gp3"
    volume_size = var.root_block_size
    encrypted   = true
    tags ={
		Tier = "${var.basename}"
    }
  }
  metadata_options {
    http_tokens = "required"
    http_endpoint = "enabled"
  }

  tags = {
    Name    = "${var.basename}-ec2-instance-${count.index}"
  }
}

resource "aws_cloudwatch_metric_alarm" "auto_recovery_alarm" {
  count               = var.instance_count
  alarm_name          = "EC2AutoRecover-${element(aws_instance.instance.*.id, count.index)}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "3"
  metric_name         = "StatusCheckFailed_System"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Minimum"

  dimensions = {
    InstanceId = element(aws_instance.instance.*.id, count.index)
  }

  alarm_actions = ["arn:aws:automate:${data.aws_region.current.name}:ec2:recover"]

  threshold         = "1"
  alarm_description = "Auto recover the EC2 instance if Status Check fails."

  tags = {
    Name    = "${var.basename}-auto-recovery-alarm"
    Details = "${data.aws_region.current.name}:tf"
  }
}
