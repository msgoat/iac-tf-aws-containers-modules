# variables.tf
# ---------------------------------------------------------------------------
# Defines all input variable for this demo.
# ---------------------------------------------------------------------------

variable region_name {
  description = "The AWS region to deploy into (e.g. eu-central-1)."
  type = string
}

variable solution_name {
  description = "The name of the AWS solution that owns all AWS resources."
  type = string
}

variable solution_stage {
  description = "The name of the current AWS solution stage."
  type = string
}

variable solution_fqn {
  description = "The fully qualified name of the current AWS solution."
  type = string
}

variable common_tags {
  description = "Common tags to be attached to all AWS resources"
  type = map(string)
}

variable vpc_id {
  description = "Unique identifier of the VPC to host the AWS EKS cluster"
  type = string
}

variable kubernetes_version {
  description = "Kubernetes version to be used for the AWS EKS cluster"
  type = string
  default = "1.18"
}

variable node_group_min_size {
  description = "Minimum size of each node group attached to the AWS EKS cluster"
  type = number
  default = 2
}

variable node_group_max_size {
  description = "Maximum size of each node group attached to the AWS EKS cluster"
  type = number
  default = 8
}