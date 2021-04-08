locals {
  node_group_subnets_ids = var.private_endpoint_enabled ? aws_subnet.private_subnets.*.id : aws_subnet.public_subnets.*.id
  node_group_subnets_zone_names = var.private_endpoint_enabled ? aws_subnet.private_subnets.*.availability_zone : aws_subnet.public_subnets.*.availability_zone
}

resource aws_eks_node_group blue {
  count = var.blue_node_group_enabled ? length(local.node_group_subnets_ids) : 0
  node_group_name = "mng-${local.node_group_subnets_zone_names[count.index]}-${local.solution_fqn}-blue"
  cluster_name = aws_eks_cluster.control_plane.name
  subnet_ids = [local.node_group_subnets_ids[count.index]]
  version = var.blue_node_group_kubernetes_version != "" ? var.blue_node_group_kubernetes_version : var.kubernetes_version
  node_role_arn = aws_iam_role.node_group.arn
  disk_size = var.blue_node_group_disk_size
  instance_types = var.blue_node_group_instance_types
  capacity_type = var.blue_node_group_capacity_type
  tags = merge({
    Name = "mng-${local.node_group_subnets_zone_names[count.index]}-${local.solution_fqn}-blue"
  }, local.module_common_tags)

  scaling_config {
    desired_size = var.blue_node_group_desired_size >= var.blue_node_group_min_size && var.blue_node_group_desired_size <= var.blue_node_group_max_size ? var.blue_node_group_desired_size : var.blue_node_group_min_size
    max_size = var.blue_node_group_max_size
    min_size = var.blue_node_group_min_size
  }

  lifecycle {
    ignore_changes = [ scaling_config[0].desired_size ]
  }
}

resource aws_eks_node_group green {
  count = var.green_node_group_enabled ? length(local.node_group_subnets_ids) : 0
  node_group_name = "mng-${local.node_group_subnets_zone_names[count.index]}-${local.solution_fqn}-green"
  cluster_name = aws_eks_cluster.control_plane.name
  subnet_ids = [local.node_group_subnets_ids[count.index]]
  version = var.green_node_group_kubernetes_version != "" ? var.green_node_group_kubernetes_version : var.kubernetes_version
  node_role_arn = aws_iam_role.node_group.arn
  disk_size = var.green_node_group_disk_size
  instance_types = var.green_node_group_instance_types
  capacity_type = var.green_node_group_capacity_type
  tags = merge({
    Name = "mng-${local.node_group_subnets_zone_names[count.index]}-${local.solution_fqn}-green"
  }, local.module_common_tags)

  scaling_config {
    desired_size = var.green_node_group_desired_size >= var.green_node_group_min_size && var.green_node_group_desired_size <= var.green_node_group_max_size ? var.green_node_group_desired_size : var.green_node_group_min_size
    max_size = var.green_node_group_max_size
    min_size = var.green_node_group_min_size
  }

  lifecycle {
    ignore_changes = [ scaling_config[0].desired_size ]
  }
}