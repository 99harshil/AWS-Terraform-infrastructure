data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_availability_zones" "available" {}

terraform {
  backend "s3" {}
}

module "vpc" {
  source                               = "../../modules/vpc/"
  create_internet_gateway              = var.enable_ig
  enable_nat_gateway                   = var.enable_ng
  name                                 = var.vpc_name
  span_azs                             = var.span_az
  aws_region                           = data.aws_region.current.name
  acl_rules                            = var.nacl_rules
  my_ip_address                        = var.my_ip_address
  nacl_port                            = var.nacl_port
}
