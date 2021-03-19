resource aws_eks_node_group workers {
  #for_each = aws_subnet.public_subnets
  count = var.blue_node_group_enabled ? length(aws_subnet.public_subnets) : 0
  # node_group_name = "ng-${each.value.availability_zone}-${var.kubernetes_cluster_name}-v1"
  node_group_name = "ng-${aws_subnet.public_subnets[count.index].availability_zone}-${local.solution_fqn}-v1"
  cluster_name = aws_eks_cluster.control_plane.name
  # subnet_ids = [each.value.id]
  subnet_ids = [aws_subnet.public_subnets[count.index].id]
  version = var.kubernetes_version
  node_role_arn = aws_iam_role.node_group.arn
  disk_size = var.node_group_disk_size
  instance_types = var.node_group_instance_types
  tags = merge({
    Name = "ng-${aws_subnet.public_subnets[count.index].availability_zone}-${local.solution_fqn}-v1"
  }, local.module_common_tags)

  scaling_config {
    desired_size = var.node_group_desired_size >= var.node_group_min_size && var.node_group_desired_size <= var.node_group_max_size ? var.node_group_desired_size : var.node_group_min_size
    max_size = var.node_group_max_size
    min_size = var.node_group_min_size
  }
}