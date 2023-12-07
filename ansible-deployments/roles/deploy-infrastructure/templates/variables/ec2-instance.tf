variable "aws_region" {
  type        = string
  description = "region"
  default     = "{{aws_region}}"
}

variable "basename" {
  type        = string
  description = "Tag substring to use for all related resources (e.g.:  test1)"
  # There should be no default for this variable.
  default     = "{{basename}}"	
}

variable "platform" {
  type        = string
  description = "OS for bastian  instance"
  default     = "{{os_platform}}"	
}

variable "ebs_encryption" {
  type   = bool
  description = "Enablling ebs encryption"
  default  = true
}

variable "instance_type" {
  type        = string
  description = "AMI Instance Type"
  default     = "{{instance_type}}"
}

variable "root_block_size" {
  type        = number
  description = "Default EBS Block volume size in gigabytes"
  default     = 20
}

variable "instance_count" {
  type        = number
  description = "Instance Count"
  default     = {{ec2_instance_count}}
}

variable "user_vpc_name" {
    type = string
    default = "{{user_vpc_name}}"
}

variable "ami_encryption" {
  type = bool
  default = false
}

variable "my_ip_address" {
  type = string
  default = "{{my_ip_address}}"
}

variable "keyname" {
  type = string
  default = "{{key_name}}"
}