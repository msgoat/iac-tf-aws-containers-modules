# Create an internet gateway to give our subnet access to the outside world
resource aws_internet_gateway igw {
  vpc_id = aws_vpc.vpc.id
  tags = merge({
    "Name" = "igw-${var.region_name}-${local.solution_fqn}"
  }, local.module_common_tags)
}

resource aws_route any_outbound_to_igw {
  count = length(aws_subnet.public_subnets)
  route_table_id = aws_route_table.public[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw.id
}
