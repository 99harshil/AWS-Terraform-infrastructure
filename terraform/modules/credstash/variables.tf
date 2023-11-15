variable "create_kms_key" {
  description = "Should the Master key be created"
  type        = string
}

variable "kms_key_name" {
  default     = "harshil"
  description = "KMS Master Key Name."
  type        = string
}

variable "enable_key_rotation" {
  default     = false
  description = "Specifies whether key rotation is enabled"
  type        = string
}

variable "create_reader_policy" {
  description = "Should credstash Secret Reader IAM Policy be created."
  type        = string
}

variable "create_writer_policy" {
  description = "Should credstash Secret Writer IAM Policy be created."
  type        = string
}
