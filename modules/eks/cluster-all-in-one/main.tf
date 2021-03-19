# ----------------------------------------------------------------------------
# main.tf
# ----------------------------------------------------------------------------

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = var.region_name
}

data aws_region current {
  name = var.region_name
}

data aws_availability_zones available_zones {
  state = "available"
}

locals {
  module_common_tags = var.common_tags
  solution_fqn = lower("${var.solution_name}-${var.solution_stage}-${var.kubernetes_cluster_name}")
  eks_cluster_name = "eks-${var.region_name}-${local.solution_fqn}"
  zones_to_span = var.zones_to_span >= 2 && var.zones_to_span < length(data.aws_availability_zones.available_zones.zone_ids) ? var.zones_to_span : length(data.aws_availability_zones.available_zones.zone_ids)
}
