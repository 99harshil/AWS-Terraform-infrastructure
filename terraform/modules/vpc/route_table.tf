data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [aws_vpc.vpc.id]
  }
  filter {
    name   = "tag:Name"
    values = ["${var.name}-*-public"]
  }
} 

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [aws_vpc.vpc.id]
  }
  filter {
    name   = "tag:Name"
    values = ["${var.name}-*-private"]
  }
}


resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id
  
  tags = { 
    Name = "${var.name}-public-route-table"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.name}-private-route-table"
  }
}

resource "aws_route" "public_internet_gateway" {
  count                  = var.create_internet_gateway ? 1 : 0
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = element("${aws_internet_gateway.internet_gateway.*.id}", count.index)

  timeouts {
    create = "5m"
  }
}

resource "aws_route" "priavte_nat_gateway" {
  count                  = var.enable_nat_gateway ? 1 : 0
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = element("${aws_nat_gateway.nat.*.id}", count.index)

  timeouts {
    create = "5m"
  }
}

resource "null_resource" "update_public_subnet_association" {
  count = var.span_azs

  triggers = {
    subnet_id = aws_subnet.public_subnet[count.index].id
  }

  provisioner "local-exec" {
    command = <<-EOT
      aws ec2 associate-route-table \
        --subnet-id ${aws_subnet.public_subnet[count.index].id} \
        --route-table-id ${aws_route_table.public.id}
    EOT
  }
}

resource "null_resource" "update_private_subnet_association" {
  count = var.span_azs

  triggers = {
    subnet_id = aws_subnet.private_subnet[count.index].id
  }

  provisioner "local-exec" {
    command = <<-EOT
      aws ec2 associate-route-table \
        --subnet-id ${aws_subnet.private_subnet[count.index].id} \
        --route-table-id ${aws_route_table.private.id}
    EOT
  }
}
