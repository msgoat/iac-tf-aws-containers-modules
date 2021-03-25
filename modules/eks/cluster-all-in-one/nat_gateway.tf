locals {
  number_of_nat_gateways = var.private_endpoint_enabled ? 1 : 0
}
resource aws_nat_gateway nat {
  count = local.number_of_nat_gateways
  subnet_id = aws_subnet.public_subnets[count.index].id
  allocation_id = aws_eip.nat[count.index].id
  tags = merge({
    Name = "nat-${aws_subnet.public_subnets[count.index].availability_zone}-${local.solution_fqn}"
  }, local.module_common_tags)
  depends_on = [ aws_internet_gateway.igw ]
}

resource aws_eip nat {
  count = local.number_of_nat_gateways
  tags = merge({
    Name = "eip-${aws_subnet.public_subnets[count.index].availability_zone}-${local.solution_fqn}-nat"
  }, local.module_common_tags)
  depends_on = [ aws_internet_gateway.igw ]
}

resource aws_route any_outbound_to_nat {
  count = var.private_endpoint_enabled ? length(aws_subnet.private_subnets) : 0
  route_table_id = aws_route_table.private[count.index].id
  nat_gateway_id = aws_nat_gateway.nat[0].id
  destination_cidr_block = "0.0.0.0/0"
}

