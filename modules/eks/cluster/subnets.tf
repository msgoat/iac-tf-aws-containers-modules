data aws_vpc vpc {
  id = var.vpc_id
}

data aws_subnet_ids subnet_ids {
  vpc_id = data.aws_vpc.vpc.id
}

data aws_subnet subnets {
  for_each = data.aws_subnet_ids.subnet_ids.ids
  id = each.value
}