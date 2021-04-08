# subnets.tf
# creates one public subnet in each availability zone

locals {
  subnet_cidrs = cidrsubnets(var.network_cidr, 4, 4, 4, 4, 4, 4, 8, 8, 8)
  public_subnet_cidrs = slice(local.subnet_cidrs, 0, 3)
  public_subnet_common_tags = merge(local.module_common_tags, {
    "kubernetes.io/cluster/${local.eks_cluster_name}" = "shared"
    "kubernetes.io/role/elb" = "1"
    "Accessibility" = "public"
  })
  private_subnet_cidrs = slice(local.subnet_cidrs, 3, 6)
  private_subnet_common_tags = merge(local.module_common_tags, {
    "kubernetes.io/cluster/${local.eks_cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb" = "1"
    "Accessibility" = "private"
  })
  data_subnet_cidrs = slice(local.subnet_cidrs, 6, 9)
  data_subnet_common_tags = merge(local.module_common_tags, {
    "Tier" = "data"
    "Accessibility" = "private"
  })
}

resource aws_subnet public_subnets {
  count = local.zones_to_span
  vpc_id = aws_vpc.vpc.id
  cidr_block = local.public_subnet_cidrs[count.index]
  availability_zone = data.aws_availability_zones.available_zones.names[count.index]
  map_public_ip_on_launch = true
  tags = merge({
    "Name" = "sn-${data.aws_availability_zones.available_zones.names[count.index]}-${local.solution_fqn}-public"
  }, local.public_subnet_common_tags)
}

resource aws_subnet private_subnets {
  count = var.private_endpoint_enabled ? local.zones_to_span : 0
  vpc_id = aws_vpc.vpc.id
  cidr_block = local.private_subnet_cidrs[count.index]
  availability_zone = data.aws_availability_zones.available_zones.names[count.index]
  map_public_ip_on_launch = false
  tags = merge({
    "Name" = "sn-${data.aws_availability_zones.available_zones.names[count.index]}-${local.solution_fqn}-private"
  }, local.private_subnet_common_tags)
}

resource aws_subnet data_subnets {
  count = local.zones_to_span
  vpc_id = aws_vpc.vpc.id
  cidr_block = local.data_subnet_cidrs[count.index]
  availability_zone = data.aws_availability_zones.available_zones.names[count.index]
  map_public_ip_on_launch = false
  tags = merge({
    "Name" = "sn-${data.aws_availability_zones.available_zones.names[count.index]}-${local.solution_fqn}-data"
  }, local.data_subnet_common_tags)
}
