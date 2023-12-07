variable "aws_region" {
  type        = string
  description = "region"
  default     = "us-east-1"
}

variable "basename" {
  type        = string
  description = "Tag substring to use for all related resources (e.g.:  test1)"
  # There should be no default for this variable.
  default     = "harshil"	
}

variable "platform" {
  type        = string
  description = "OS for bastian  instance"
  default     = "amazon-2_lts"	
}

variable "ebs_encryption" {
  type   = bool
  description = "Enablling ebs encryption"
  default  = true
}

variable "instance_type" {
  type        = string
  description = "AMI Instance Type"
  default     = "t2.micro"
}

variable "root_block_size" {
  type        = number
  description = "Default EBS Block volume size in gigabytes"
  default     = 20
}

variable "instance_count" {
  type        = number
  description = "Instance Count"
  default     = 1
}

variable "user_vpc_name" {
    type = string
    default = "harshil-vpc"
}

variable "ami_encryption" {
  type = bool
  default = false
}

variable "my_ip_address" {
  type = string
  default = "192.168.169.133"
}

variable "keyname" {
  type = string
  default = "ssh_rsa"
}
