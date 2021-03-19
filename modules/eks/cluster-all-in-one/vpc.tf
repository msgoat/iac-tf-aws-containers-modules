# Creates a VPC to host your AWS EKS cluster
resource aws_vpc vpc {
  cidr_block = var.network_cidr
  # all public available instances should have DNS names
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = merge({
    "Name" = "vpc-${var.region_name}-${local.solution_fqn}"
    "kubernetes.io/cluster/${local.eks_cluster_name}" = "shared"
  },
  local.module_common_tags)
}


