variable "basename" {
  type        = string
  description = "Tag substring to use for all related resources (e.g.:  test1)"
  # There should be no default for this variable.
}

variable "block_public_acls" {
  type        = string
  description = "blocks public acls to backend s3 bucket"
  default     = true
}

variable "block_public_policy" {
  type        = string
  description = "blocks public policy to backend s3 bucket"
  default     = true
}

variable "ignore_public_acls" {
  type        = string
  description = "ignores public acls to backend s3 bucket"
  default     = true
}

variable "restrict_public_buckets" {
  type        = string
  description = "restricts public to backend s3 bucket"
  default     = true
}

variable "bucket_name" {
  type        = string
  description = "Name of s3 bucket to use for all AWS resources"

}

variable "table_name" {
  type        = string
  description = "Name of dynamodb table to use for all AWS resources"
}


