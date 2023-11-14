resource "aws_eip" "nat" {
   count  = var.enable_nat_gateway ? 1 : 0
   domain = "vpc"
}

resource "aws_nat_gateway" "nat" {
  count  = var.enable_nat_gateway ? 1 : 0
  allocation_id = "${aws_eip.nat[count.index].id}"
  subnet_id     = "${aws_subnet.public_subnet.0.id}"
  tags = {
    Name = "${var.name}-nat-gateway"
  }
}
