resource "aws_internet_gateway" "internet_gateway" {
  count  = var.create_internet_gateway ? 1 : 0
  vpc_id = "${aws_vpc.vpc.id}"
  tags = {
    Name        = "${var.name}-internet-gateway"
  }
}
