data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_availability_zones" "available" {}

terraform {
  backend "s3" { 
    bucket         = "tfstate-harshil-bucket"
    key            = "networking/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "tfstate-harshil-table"
    encrypt        = true

  }
}

module "vpc" {
  source                               = "../../modules/vpc/"
  name                                 = var.vpc_name
  span_azs                             = var.span_az
  aws_region                           = data.aws_region.current.name
  acl_rules                            = var.nacl_rules
}
