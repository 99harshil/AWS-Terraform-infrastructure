output "aws_region" {
  value       = module.terraform_backend.region
  description = "region"
}

output "bucket" {
  value       = module.terraform_backend.bucket
  description = "bucket name"
}

output "dynamodb_table" {
  value       = module.terraform_backend.dynamodb_table
  description = "dynamodb_table name"
}

