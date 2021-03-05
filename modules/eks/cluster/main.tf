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

# Local values used in this module
locals {
  module_common_tags = var.common_tags
  eks_cluster_name = "eks-${var.region_name}-${var.solution_fqn}"
}

data aws_region current {
  name = var.region_name
}

data aws_availability_zones available_zones {
  state = "available"
}

output available_zones {
  value = data.aws_availability_zones.available_zones.names
}
