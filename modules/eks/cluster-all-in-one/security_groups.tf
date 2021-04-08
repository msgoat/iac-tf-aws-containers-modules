resource aws_security_group cluster_shared_node {
  name = "sec-${local.eks_cluster_name}-cluster-shared-node"
  description = "controls traffic between worker nodes"
  vpc_id = aws_vpc.vpc.id
  tags = merge({
    Name = "sg-${local.eks_cluster_name}-cluster-shared-node"
  }, local.module_common_tags)
}

resource aws_security_group_rule allow_any_ingress_from_lb {
  type = "ingress"
  description = "allow any inbound traffic from loadbalancer to ingress controller using node ports"
  from_port = 30000
  to_port = 32767
  protocol = "TCP"
  source_security_group_id = aws_security_group.lb_to_ingress.id
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

resource aws_security_group lb_to_ingress {
  name = "sec-${local.eks_cluster_name}-lb-to-ingress"
  description = "controls traffic between external loadbalancer and ingress controller"
  vpc_id = aws_vpc.vpc.id
  tags = merge({
    Name = "sg-${local.eks_cluster_name}-lb-to-ingress"
  }, local.module_common_tags)
}

resource aws_security_group_rule allow_any_egress_from_lb {
  type = "egress"
  description = "allow any outbound traffic from external loadbalancer to ingress controller"
  from_port = 0
  to_port = 65535
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.lb_to_ingress.id
}
