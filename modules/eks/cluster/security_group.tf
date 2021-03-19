# security_group.tf
#----------------------------------------------------------------------
# creates the security groups supposed to control traffic to the ingress controller of the AKS cluster
#----------------------------------------------------------------------
#

locals {
  security_group_name = "sec-${local.eks_cluster_name}-worker-from-lb"
}

resource aws_security_group ingress {
  name = local.security_group_name
  description = "Allow EKS workers to accept traffic from loadbalancer to ingress controller"
  vpc_id = data.aws_vpc.vpc.id
  tags = merge({ Name = local.security_group_name }, local.module_common_tags)
}

resource aws_security_group_rule allow_http_from_lb {
  type = "ingress"
  from_port = 32080
  to_port = 32080
  protocol = "tcp"
  security_group_id = aws_security_group.ingress.id
  source_security_group_id = var.loadbalancer_security_group_id
}

