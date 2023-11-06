output "acl" {
  value       = "private"
  description = "Acl line needed for backend"
}

output "bucket" {
  value       = aws_s3_bucket.terraform_state.id
  description = "bucket name"
}

output "encrypt" {
  value       = true
  description = "turn encryption on"
}

output "key" {
  value       = "${var.basename}/terraform.tfstate"
  description = "key location, may have to be adjusted"
}

output "dynamodb_table" {
  value       = aws_dynamodb_table.terraform_lock.id
  description = "dynamodb_table name"
}

output "region" {
  value       = data.aws_region.current.name
  description = "region"
}

