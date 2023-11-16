output "kms_key_arn" {
  value       = module.credstash.kms_key_arn
  description = "KMS Key ARN. It can later be used to store and retrieve secrets."
}

output "kms_key_id" {
  value       = module.credstash.kms_key_id
  description = "KMS Master key id."
}

output "kms_key_alias" {
  value       = module.credstash.kms_key_alias
  description = "KMS Master key alias. It can later be used to store and retrieve secrets."
}

output "kms_key_alias_arn" {
  value       = module.credstash.kms_key_alias_arn
  description = "KMS Master key alias ARN."
}

output "db_table_arn" {
  value       = module.credstash.db_table_arn
  description = "DynamoDB table ARN that can be used by credstash to store/retrieve secrets."
}

output "db_table_name" {
  value       = module.credstash.db_table_name
  description = "DynamoDB table name that can be used by credstash to store/retrieve secrets."
}

output "reader_policy_arn" {
  value       = module.credstash.reader_policy_arn
  description = "Secret Reader policy"
}

output "writer_policy_arn" {
  value       = module.credstash.writer_policy_arn
  description = "Secret Writer policy"
}
