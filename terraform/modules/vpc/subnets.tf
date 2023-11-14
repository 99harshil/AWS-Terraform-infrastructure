resource "aws_subnet" "public_subnet" {
  count                   = "${var.span_azs}"
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${cidrsubnet(var.cidr_block, 8, count.index)}"
  availability_zone       = "${element(var.availability_zones[var.aws_region], count.index)}"
  map_public_ip_on_launch = "${var.public_subnet_map_public_ip_on_launch}"
  tags = {
    Name        = "${var.name}-${element(var.availability_zones[var.aws_region], count.index)}-public"
  }
}

resource "aws_subnet" "private_subnet" {
  count                   = "${var.span_azs}"
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${cidrsubnet(var.cidr_block, 8, length(var.availability_zones[var.aws_region]) + count.index)}"
  availability_zone       = "${element(var.availability_zones[var.aws_region], count.index)}"
  map_public_ip_on_launch = false
  tags = {
    Name        = "${var.name}-${element(var.availability_zones[var.aws_region], count.index)}-private"
  }
}
