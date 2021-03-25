locals {
  node_group_subnets_ids = var.private_endpoint_enabled ? aws_subnet.private_subnets.*.id : aws_subnet.public_subnets.*.id
  node_group_subnets_zone_names = var.private_endpoint_enabled ? aws_subnet.private_subnets.*.availability_zone : aws_subnet.public_subnets.*.availability_zone
}

resource aws_eks_node_group workers {
  #for_each = aws_subnet.public_subnets
  count = var.blue_node_group_enabled ? length(aws_subnet.public_subnets) : 0
  # node_group_name = "ng-${each.value.availability_zone}-${var.kubernetes_cluster_name}-v1"
  node_group_name = "mng-${local.node_group_subnets_zone_names[count.index]}-${local.solution_fqn}-v1"
  cluster_name = aws_eks_cluster.control_plane.name
  # subnet_ids = [each.value.id]
  subnet_ids = [local.node_group_subnets_ids[count.index]]
  version = var.kubernetes_version
  node_role_arn = aws_iam_role.node_group.arn
  disk_size = var.node_group_disk_size
  instance_types = var.node_group_instance_types
  capacity_type = "SPOT"
  tags = merge({
    Name = "mng-${local.node_group_subnets_zone_names[count.index]}-${local.solution_fqn}-v1"
  }, local.module_common_tags)

  scaling_config {
    desired_size = var.node_group_desired_size >= var.node_group_min_size && var.node_group_desired_size <= var.node_group_max_size ? var.node_group_desired_size : var.node_group_min_size
    max_size = var.node_group_max_size
    min_size = var.node_group_min_size
  }

  lifecycle {
    ignore_changes = [ scaling_config[0].desired_size ]
  }
}