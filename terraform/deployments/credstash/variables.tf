variable "create_credstash" {
  type        = bool
  description = "Bool value for creating credstash module"
  default     = "true"
}

variable "name" {
  type        = string
  description = "Name of credstash module"
  default     = "harshil"
}

variable "read_policy" {
  type        = bool
  description = "Bool value for creating read policy"
  default     = "true"
}

variable "write_policy" {
  type        = bool
  description = "Bool value for creating write policy"
  default     = "true"
}

variable "aws_region" {
  description = "Region of AWS cloud"
  type = string
  default = "us-east-1"
}

