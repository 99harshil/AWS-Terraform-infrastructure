variable "basename" {
  type        = string
  description = "Tag substring to use for all related resources (e.g.:  test1)"
  # There should be no default for this variable.
}

variable "enable_monitoring" {
  type        = bool
  description = "Enable EC2 Instance Monitoring"
  default     = false
}

variable "instance_count" {
  type        = number
  description = "Instance Count"
  default     = 1
}

variable "instance_type" {
  type        = string
  description = "AMI Instance Type"
  default     = "t3.micro"
}

variable "key_name" {
  type        = string
  description = "key name"
}

variable "root_block_size" {
  type        = number
  description = "Default EBS Block volume size in gigabytes"
  default     = 8
}

variable "security_group_ids" {
  type        = list(any)
  description = "list of security groups"
}

variable "subnet_ids" {
  type        = list(any)
  description = "list of subnet ids"
}

variable "platform" {
  type        = string
  description = "AMI owner name"
}

variable "amis_os_map_regex" {
  description = "Map of regex to search amis"
  type = map(string)

  default = {
    "centos-6"     = "^CentOS.Linux.6.*x86_64.*"
    "centos-7"     = "^CentOS.Linux.7.*x86_64.*"
    "centos-8"     = "^CentOS.Linux.8.*x86_64.*"
    "rhel-6"       = "^RHEL-6.*x86_64.*"
    "rhel-7"       = "^RHEL-7.*x86_64.*"
    "rhel-8"       = "^RHEL-8.*x86_64.*"
    "rhel-9"       = "^RHEL-9.*x86_64.*"
    "amazon-2_lts" = "^al2023-ami-2023.*x86_64"
  }
}

variable "user_data" {
  type        = string
  description = "User data"
}
