terraform {
  backend "s3" {
    bucket         = "tfstate-harshil-bucket"
    key            = "credstash/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "tfstate-harshil-table"
    encrypt        = true

  }
}

module "credstash" {
  source               = "../../modules/credstash"
  create_kms_key       = var.create_credstash
  kms_key_name         = var.name
  create_reader_policy = var.read_policy
  create_writer_policy = var.write_policy
}
