# ----------------------------------------------------------------------------
# main.tf
# ----------------------------------------------------------------------------

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
    local = {
      version = "~> 2.1"
    }
    null = {
      version = "~> 3.1"
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
  eks_cluster_name = "eks-${var.region_name}-${var.kubernetes_cluster_name}"
  zones_to_span = var.zones_to_span >= 2 && var.zones_to_span < length(data.aws_availability_zones.available_zones.zone_ids) ? var.zones_to_span : length(data.aws_availability_zones.available_zones.zone_ids)
  node_group_desired_size = var.node_group_desired_size >= var.node_group_min_size && var.node_group_desired_size <= var.node_group_max_size ? var.node_group_desired_size : var.node_group_min_size
}
