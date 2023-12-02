terraform {
  backend "s3" {}
}

module "credstash" {
  source               = "../../modules/credstash"
  create_kms_key       = var.create_credstash
  kms_key_name         = var.name
  create_reader_policy = var.read_policy
  create_writer_policy = var.write_policy
}
