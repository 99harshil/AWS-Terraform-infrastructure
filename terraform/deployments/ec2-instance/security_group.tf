locals {
  ssh_port      = 22
  protocol      = "tcp"
  http_port     = 80
  https_port    = 443
  http_cidr     = ["0.0.0.0/0"]
  rds_port      = 5432
  mssql_port    = 1433
  oracle_port   = 1521
}

data "aws_subnet" "rds" {
  for_each = toset(data.aws_subnets.private.ids)
  id       = each.value
}

locals {
    rds = [for s in data.aws_subnet.rds :
    {
     rds_ip  = s.cidr_block
    }
  ]
}

resource "aws_security_group" "ec2_instance_rules" {
  name        = "EC2 instance security group rules"
  description = "Allow inbound and outbound traffic in EC2 instance"
  vpc_id      = data.aws_vpc.network_state.id
  
  ingress {
     description = "Ingress SSH rule"
     from_port   = local.ssh_port
     to_port     = local.ssh_port
     protocol    = local.protocol
     cidr_blocks = "${formatlist("%s/32",var.my_ip_address)}"
  }

  egress {
       from_port   = local.rds_port
       to_port     = local.rds_port
       protocol    = local.protocol
       cidr_blocks = "${local.rds.*.rds_ip}"
  }
  
  egress {
       from_port   = local.mssql_port
       to_port     = local.mssql_port
       protocol    = local.protocol
       cidr_blocks = "${local.rds.*.rds_ip}"
  }

  egress {
       from_port   = local.oracle_port
       to_port     = local.oracle_port
       protocol    = local.protocol
       cidr_blocks = "${local.rds.*.rds_ip}"
  }

  egress {
       from_port   = local.http_port
       to_port     = local.http_port
       protocol    = local.protocol
       cidr_blocks = local.http_cidr
  }
  egress {
       from_port   = local.https_port
       to_port     = local.https_port
       protocol    = local.protocol
       cidr_blocks = local.http_cidr
  }
 tags = {
    Name    = "EC2 Instance Security Group Rules"
    Tier    = "${var.basename}"
   }
}

  
