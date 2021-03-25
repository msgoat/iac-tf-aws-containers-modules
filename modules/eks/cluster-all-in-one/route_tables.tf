# route_tables.tf
# creates and adds a dedicated custom route table to each subnet

resource aws_route_table public {
  count = length(aws_subnet.public_subnets)
  vpc_id = aws_vpc.vpc.id
  tags = merge({
    Name = "rtb-${aws_subnet.public_subnets[count.index].availability_zone}-${local.solution_fqn}-public"
  }, local.module_common_tags)
}

resource aws_route_table_association public {
  count = length(aws_subnet.public_subnets)
  route_table_id = aws_route_table.public[count.index].id
  subnet_id = aws_subnet.public_subnets[count.index].id
}

resource aws_route_table private {
  count = var.private_endpoint_enabled ? length(aws_subnet.private_subnets) : 0
  vpc_id = aws_vpc.vpc.id
  tags = merge({
    Name = "rtb-${aws_subnet.private_subnets[count.index].availability_zone}-${local.solution_fqn}-private"
  }, local.module_common_tags)
}

resource aws_route_table_association private {
  count = var.private_endpoint_enabled ? length(aws_subnet.private_subnets) : 0
  route_table_id = aws_route_table.private[count.index].id
  subnet_id = aws_subnet.private_subnets[count.index].id
}
