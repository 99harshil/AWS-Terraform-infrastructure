data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

terraform {
  backend "s3" {}
}


data "aws_vpc" "network_state" {
    tags = {
        Name = "${var.user_vpc_name}"
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.network_state.id]
  }
  filter {
    name   = "tag:Name"
    values = ["${var.basename}-*-private"]
  }

 } 

module "ec2_instance" {
  source                 = "../../modules/ec2"
  basename               = var.basename
  instance_count         = var.instance_count
  instance_type          = var.instance_type
  platform               = var.platform
  subnet_ids             = data.aws_subnets.private.ids
  root_block_size        = var.root_block_size
  key_name               = var.keyname
  security_group_ids     = flatten(["${aws_security_group.ec2_instance_rules.id}"])
  user_data              =  ""
}

resource "aws_ebs_encryption_by_default" "enabled" {
     enabled = "${var.ebs_encryption}"
}

