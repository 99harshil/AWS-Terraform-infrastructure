resource "aws_network_acl" "public" {
  vpc_id     = aws_vpc.vpc.id
  subnet_ids = data.aws_subnets.public.ids
  tags       = {
     Name = "${var.name}-public-nacl"
  }
}

resource "aws_network_acl" "private" {
  vpc_id     = aws_vpc.vpc.id
  subnet_ids = data.aws_subnets.private.ids
  tags       = {
     Name = "${var.name}-private-nacl"
  }
}


# 100 rule number for public subnet user ingress rule
# 200 rule number for public subnet default ingress rule
# 300 rule number for public subnet user egress rule
# 400 rule number for public subnet default egress rule
# 500 rule number for private subnet user ingress rule
# 600 rule number for private subnet default ingress rule
# 700 rule number for private subnet user egress rule
# 800 rule number for private subnet default egress rule

resource "aws_network_acl_rule" "public_inbound_customize_rule" {
  count           = length(var.nacl_port)
  network_acl_id  = aws_network_acl.public.id
  rule_number     = (100+(count.index*10))
  egress          = "false"
  rule_action     = "allow"
  protocol        = "tcp"
  from_port       = var.nacl_port[count.index]
  to_port         = var.nacl_port[count.index]
  cidr_block      = "${format("%s/32",var.my_ip_address)}"
}

resource "aws_network_acl_rule" "public_inbound_default_rule" {
  count           = length(var.acl_rules) 
  network_acl_id  = aws_network_acl.public.id
  rule_number     = (200+(count.index*10))
  egress          = "false"
  rule_action     = var.acl_rules[count.index]["rule_action"]
  protocol        = var.acl_rules[count.index]["protocol"]
  from_port       = lookup(var.acl_rules[count.index], "from_port", null)
  to_port         = lookup(var.acl_rules[count.index], "to_port", null)
  cidr_block      = var.acl_rules[count.index]["cidr_block"]
  ipv6_cidr_block = lookup(var.acl_rules[count.index], "ipv6_cidr_block", null)
}

resource "aws_network_acl_rule" "public_outbound_default_rule" {
  count           = length(var.acl_rules)
  network_acl_id  = aws_network_acl.public.id
  rule_number     = (400+(count.index*10))
  egress          = "true"
  rule_action     = var.acl_rules[count.index]["rule_action"]
  protocol        = var.acl_rules[count.index]["protocol"]
  from_port       = lookup(var.acl_rules[count.index], "from_port", null)
  to_port         = lookup(var.acl_rules[count.index], "to_port", null)
  cidr_block      = var.acl_rules[count.index]["cidr_block"]
  ipv6_cidr_block = lookup(var.acl_rules[count.index], "ipv6_cidr_block", null)
}

resource "aws_network_acl_rule" "public_outbound_customize_rule" {
  count           = length(var.nacl_port)
  network_acl_id  = aws_network_acl.public.id
  rule_number     = (300+(count.index*10))
  egress          = "true"
  rule_action     = "allow"
  protocol        = "tcp"
  from_port       = var.nacl_port[count.index]
  to_port         = var.nacl_port[count.index]
  cidr_block      = "${format("%s/32",var.my_ip_address)}"
}

resource "aws_network_acl_rule" "private_inbound_default_rule" {
  count           = length(var.acl_rules)
  network_acl_id  = aws_network_acl.private.id
  rule_number     = (700+(count.index*10))
  egress          = "false"
  rule_action     = var.acl_rules[count.index]["rule_action"]
  protocol        = var.acl_rules[count.index]["protocol"]
  from_port       = lookup(var.acl_rules[count.index], "from_port", null)
  to_port         = lookup(var.acl_rules[count.index], "to_port", null)
  cidr_block      = var.acl_rules[count.index]["cidr_block"]
  ipv6_cidr_block = lookup(var.acl_rules[count.index], "ipv6_cidr_block", null)
}

resource "aws_network_acl_rule" "private_inbound_customize_rule" {
  count           = length(var.nacl_port)
  network_acl_id  = aws_network_acl.private.id
  rule_number     = (500+(count.index*10))
  egress          = "false"
  rule_action     = "allow"
  protocol        = "tcp"
  from_port       = var.nacl_port[count.index]
  to_port         = var.nacl_port[count.index]
  cidr_block      = "${format("%s/32",var.my_ip_address)}"
}

resource "aws_network_acl_rule" "private_outbound_default_rule" {
  count           = length(var.acl_rules)
  network_acl_id  = aws_network_acl.private.id
  rule_number     = (800+(count.index*10))
  egress          = "true"
  rule_action     = var.acl_rules[count.index]["rule_action"]
  protocol        = var.acl_rules[count.index]["protocol"]
  from_port       = lookup(var.acl_rules[count.index], "from_port", null)
  to_port         = lookup(var.acl_rules[count.index], "to_port", null)
  cidr_block      = var.acl_rules[count.index]["cidr_block"]
  ipv6_cidr_block = lookup(var.acl_rules[count.index], "ipv6_cidr_block", null)
}

resource "aws_network_acl_rule" "private_outbound_customize_rule" {
  count           = length(var.nacl_port)
  network_acl_id  = aws_network_acl.private.id
  rule_number     = (600+(count.index*10))
  egress          = "true"
  rule_action     = "allow"
  protocol        = "tcp"
  from_port       = var.nacl_port[count.index]
  to_port         = var.nacl_port[count.index]
  cidr_block      = "${format("%s/32",var.my_ip_address)}"
}

