variable "vpc_name" {
  description = "name of vpc"
  type = string
  default = "harshil"
}

variable "aws_region" {
  description = "Region of AWS cloud"
  type = string
  default = "us-east-1"
}

variable "span_az" {
  description = "Number of availability zones"
  type        = number
  default     = 2
}

variable "enable_ig" {
  type        = bool
  description = "Value for creating Intenet Gatewway"
  default     = "true"
}

variable "enable_ng" {
  type        = bool
  description = "Value for creating NAT Gateway"
  default     = "true"
}

variable "nacl_rules" {
  description = "defining inbound and outbound rules"
  type        = list(map(string))
  default = [
    {
      rule_action = "allow"
      from_port   = 1024
      to_port     = 65535
      protocol    = "tcp"
      cidr_block  = "0.0.0.0/0"
    },
    {
      rule_action = "allow"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_block  = "0.0.0.0/0"
    },
    {
      rule_action = "allow"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_block  = "0.0.0.0/0"
    }
  ]
}

variable "my_ip_address" {
  type    = string
  default = "192.168.169.133"
}

variable "nacl_port" {
  type = list(any)

  default = ["22", "8080"]
}
