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

resource "aws_network_acl_rule" "public_inbound_default_rule" {
  count           = length(var.acl_rules) 
  network_acl_id  = aws_network_acl.public.id
  rule_number     = (100+(count.index)*10)
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
  rule_number     = (200+(count.index)*10)
  egress          = "true"
  rule_action     = var.acl_rules[count.index]["rule_action"]
  protocol        = var.acl_rules[count.index]["protocol"]
  from_port       = lookup(var.acl_rules[count.index], "from_port", null)
  to_port         = lookup(var.acl_rules[count.index], "to_port", null)
  cidr_block      = var.acl_rules[count.index]["cidr_block"]
  ipv6_cidr_block = lookup(var.acl_rules[count.index], "ipv6_cidr_block", null)
}

resource "aws_network_acl_rule" "private_inbound_default_rule" {
  count           = length(var.acl_rules)
  network_acl_id  = aws_network_acl.private.id
  rule_number     = (100+(count.index)*10)
  egress          = "false"
  rule_action     = var.acl_rules[count.index]["rule_action"]
  protocol        = var.acl_rules[count.index]["protocol"]
  from_port       = lookup(var.acl_rules[count.index], "from_port", null)
  to_port         = lookup(var.acl_rules[count.index], "to_port", null)
  cidr_block      = var.acl_rules[count.index]["cidr_block"]
  ipv6_cidr_block = lookup(var.acl_rules[count.index], "ipv6_cidr_block", null)
}

resource "aws_network_acl_rule" "private_outbound_default_rule" {
  count           = length(var.acl_rules)
  network_acl_id  = aws_network_acl.private.id
  rule_number     = (200+(count.index)*10)
  egress          = "true"
  rule_action     = var.acl_rules[count.index]["rule_action"]
  protocol        = var.acl_rules[count.index]["protocol"]
  from_port       = lookup(var.acl_rules[count.index], "from_port", null)
  to_port         = lookup(var.acl_rules[count.index], "to_port", null)
  cidr_block      = var.acl_rules[count.index]["cidr_block"]
  ipv6_cidr_block = lookup(var.acl_rules[count.index], "ipv6_cidr_block", null)
}
