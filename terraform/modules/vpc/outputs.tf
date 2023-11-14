output "vpc_id" {
  description = "The id of the VPC."
  value       = "${aws_vpc.vpc.id}"
}

output "vpc_cidr" {
  description = "The CDIR block used for the VPC."
  value       = "${aws_vpc.vpc.cidr_block}"
}

output "internet_gateway" {
  description = "Intenet Gateway id for allowing elements to access internet"
  value       = ["${aws_internet_gateway.internet_gateway.*.id}"]
}

output "public_subnets" {
  description = "A list of the public subnets."
  value       = ["${aws_subnet.public_subnet.*.id}"]
}

output "private_subnets" {
  description = "A list of the private subnets."
  value       = ["${aws_subnet.private_subnet.*.id}"]
}

output "availability_zones" {
  description = "List of the availability zones."
  value       = "${var.availability_zones[var.aws_region]}"
}

output "main_route_table_id" {
  description = "Id of main route table"
  value       = "${aws_vpc.vpc.default_route_table_id}"
}

output "public_route_table_id" {
  description = "Id of public route table"
  value       = "${aws_route_table.public.id}"
}

output "private_route_table_id" {
  description = "Id of private route table"
  value       = "${aws_route_table.private.id}"
}

output "nat_gateway_id" {
  description = "ID of NAT Gateway"
  value       = [aws_nat_gateway.nat.*.id]
}

output "public_nacl_id" {
  description = "Id of public Nacl"
  value       = aws_network_acl.public.id
}

output "private_nacl_id" {
  description = "Id of private Nacl"
  value       = aws_network_acl.private.id
}
