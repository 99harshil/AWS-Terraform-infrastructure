data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

module "terraform_backend" {
  source     = "../modules/backend"
  basename   = var.basename
  bucket_name= var.bucket_name
  table_name = var.table_name  
}

