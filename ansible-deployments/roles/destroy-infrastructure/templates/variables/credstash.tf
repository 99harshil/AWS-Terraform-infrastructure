variable "create_credstash" {
  type        = bool
  description = "Bool value for creating credstash module"
  default     = "{{create_credstash_table}}"
}

variable "name" {
  type        = string
  description = "Name of credstash module"
  default     = "{{basename}}"
}

variable "read_policy" {
  type        = bool
  description = "Bool value for creating read policy"
  default     = "{{enable_read_policy}}"
}

variable "write_policy" {
  type        = bool
  description = "Bool value for creating write policy"
  default     = "{{enable_write_policy}}"
}

variable "aws_region" {
  description = "Region of AWS cloud"
  type = string
  default = "{{aws_region}}"
}

