# Create an internet gateway to give our subnet access to the outside world
resource aws_internet_gateway igw {
  vpc_id = aws_vpc.vpc.id
  tags = merge({
    "Name" = "igw-${var.region_name}-${lower(var.solution_fqn)}"
  }, local.module_common_tags)
}
