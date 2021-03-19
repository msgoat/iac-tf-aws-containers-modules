resource aws_security_group cluster_shared_node {
  name = "sec-${local.eks_cluster_name}-cluster-shared-node"
  description = "controls traffic between worker nodes"
  vpc_id = aws_vpc.vpc.id
  tags = merge({
    Name = "sg-${local.eks_cluster_name}-cluster-shared-node"
  }, local.module_common_tags)
}

resource aws_security_group_rule allow_any_ingress_between_nodes {
  type = "ingress"
  description = "allow any inbound traffic to nodes from nodes of the same cluster"
  from_port = 0
  to_port = 65535
  protocol = "-1"
  self = true
  security_group_id = aws_security_group.cluster_shared_node.id
}

resource aws_security_group_rule allow_any_egress_from_nodes {
  type = "egress"
  description = "allow any outbound traffic from nodes"
  from_port = 0
  to_port = 65535
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.cluster_shared_node.id
}
