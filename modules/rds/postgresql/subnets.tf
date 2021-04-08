data aws_subnet_ids data {
  vpc_id = data.aws_vpc.network.id
  tags = {
    Tier = "data"
  }
}

data aws_subnet data {
  for_each = data.aws_subnet_ids.data.ids
  id = each.value
}