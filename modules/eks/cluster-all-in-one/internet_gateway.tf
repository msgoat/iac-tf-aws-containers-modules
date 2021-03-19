# Create an internet gateway to give our subnet access to the outside world
resource aws_internet_gateway igw {
  vpc_id = aws_vpc.vpc.id
  tags = merge({
    "Name" = "igw-${var.region_name}-${local.solution_fqn}"
  }, local.module_common_tags)
}

# route all outbound internet traffic from public subnets through the Internet Gateway
resource aws_route_table internet_route_table {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = merge({
    "Name" = "rtb-${var.region_name}-${local.solution_fqn}-igw"
  }, local.module_common_tags)
}

resource aws_route_table_association internet_route_table_association {
  count = length(aws_subnet.public_subnets)
  subnet_id = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.internet_route_table.id
}
