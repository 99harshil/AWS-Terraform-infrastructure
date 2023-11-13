variable "cidr_block" {
  description = "The CDIR block used for the VPC."
  type        = string
  default     = "172.0.0.0/16"
}

variable "aws_region" {
  type        = string
  description = "The Amazon region."
}

variable "availability_zones" {
  type = map

  default = {
    us-east-1      = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d", "us-east-1e", "us-east-1f"]
    us-east-2      = ["us-east-2a", "eu-east-2b", "eu-east-2c"]
    ca-central-1   = ["ca-central-1a", "ca-central-1b"]
  }
}

variable "public_subnet_map_public_ip_on_launch" {
  type        = bool
  description = "Set the default behavior for instances created in the VPC. If true by default a public ip will be assigned."
  default     = "false"
}

variable "span_azs" {
  type        = number
  description = "Number of availability zones to deploy"
}

variable "name" {
  type        = string
  description = "Name of Networking elements"
}

variable "create_internet_gateway" {
  type        = bool
  description = "Bool value for creating Internet gateway"
}

variable "enable_nat_gateway" {
  type        = bool
  description = "bool value for creating Nat Gateway"
}

# NACL Rule Numbers
# 1xx: General public ingress
# 2xx: General public egress
# 3xx: General private ingress
# 4xx: General private egress

variable "acl_rules" {
  description = "Network ACLs rules for public and private subnets"
  type        = list(map(string))
}
