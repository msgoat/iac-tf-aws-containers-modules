# subnets.tf
# creates one public subnet in each availability zone

locals {
  subnet_cidrs = cidrsubnets(var.network_cidr, 3, 3, 3)
  public_subnet_cidrs = slice(local.subnet_cidrs, 0, 3)
  public_subnet_common_tags = merge(local.module_common_tags, map("kubernetes.io/role/elb", "1", "kubernetes.io/cluster/${var.eks_cluster_name}", "shared"))
}

resource aws_subnet public_subnets {
  count = length(data.aws_availability_zones.available_zones.names)
  vpc_id = aws_vpc.vpc.id
  cidr_block = local.public_subnet_cidrs[count.index]
  availability_zone = data.aws_availability_zones.available_zones.names[count.index]
  map_public_ip_on_launch = true
  tags = merge(map("Name", "subnet-${data.aws_availability_zones.available_zones.names[count.index]}-${var.solution_fqn}-public"), local.public_subnet_common_tags)
}

# route all outbound internet traffic from public subnets through the Internet Gateway
resource aws_route_table internet_route_table {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = merge(map(
  "Name", "rtb-${data.aws_region.current.name}-${var.solution_fqn}-igw"
  ), local.public_subnet_common_tags)
}

resource aws_route_table_association internet_route_table_association {
  count = length(aws_subnet.public_subnets)
  subnet_id = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.internet_route_table.id
}
