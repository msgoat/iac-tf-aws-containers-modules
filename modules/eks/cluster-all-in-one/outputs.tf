output kube_config_file_name {
  description = "Full pathname of the Kubernetes configuration file to access this AWS EKS cluster"
  value = local_file.kube_config.filename
}

output eks_cluster_arn {
  description = "Unique identifier of the AWS EKS cluster"
  value = aws_eks_cluster.control_plane.arn
}

output eks_cluster_name {
  description = "Name of the AWS EKS cluster"
  value = aws_eks_cluster.control_plane.name
}

output vpc_id {
  description = "Unqiue identifier of the VPC hosting the AWS EKS cluster"
  value = aws_vpc.vpc.id
}

output public_subnet_ids {
  description = "Unique identifiers of all public subnets inside the VPC"
  value = aws_subnet.public_subnets.*.id
}

output private_subnet_ids {
  description = "Unique identifiers of all private subnets inside the VPC"
  value = var.private_endpoint_enabled ? aws_subnet.private_subnets.*.id : []
}

output data_subnet_ids {
  description = "Unique identifiers of all data subnets inside the VPC"
  value = aws_subnet.data_subnets.*.id
}

output loadbalancer_security_group_id {
  description = "Unique identifier of a security group which allows an external loadbalancer to talk to the ingress controller via node ports"
  value = aws_security_group.lb_to_ingress.id
}