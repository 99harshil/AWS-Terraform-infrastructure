variable "aws_region" {
  type        = string
  description = "AWS region"
  default     = "{{aws_region}}"
}

variable "basename" {
  type        = string
  description = "Name tag prefix to use for all AWS resources"
  default     = "{{basename}}"
}

variable "bucket_name" {
  type        = string
  description = "Name of s3 bucket to use AWS resources"
  default     = "{{backend_s3_bucket_name}}"
}

variable "table_name" {
  type        = string
  description = "Name of dynamodb table to use for all AWS resources"
  default     = "{{backend_dynamodb_name}}"
}

