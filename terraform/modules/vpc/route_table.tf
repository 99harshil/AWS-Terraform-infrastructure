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

resource "aws_route_table_association" "public" {
  count          = var.span_azs
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count          = var.span_azs
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.private.id
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.internet_gateway.id}"

  timeouts {
    create = "5m"
  }
}

resource "aws_route" "priavte_nat_gateway" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_nat_gateway.nat.id}"

  timeouts {
    create = "5m"
  }
}

