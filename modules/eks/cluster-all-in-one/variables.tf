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

variable network_cidr {
  description = "The CIDR range of the VPC."
  type = string
}

variable zones_to_span {
 description = "Number of availability zones the AWS EKS cluster should span; cluster will span two available availability zones, if not specified"
  type = number
  default = 2
}

variable inbound_traffic_cidrs {
  description = "The IP ranges in CIDR notation allowed to access any public resource within the network."
  type = list(string)
}

variable kubernetes_version {
  description = "Kubernetes version"
  type = string
  default = "1.19"
}

variable kubernetes_cluster_name {
  description = "Logical name of the AWS EKS cluster"
  type = string
}

variable blue_node_group_enabled {
  description = "controls if the blue managed node group should be enabled"
  type = bool
  default = true
}

variable blue_node_group_kubernetes_version {
  description = "Kubernetes version of the blue node group; will default to kubernetes_version, if not specified but may differ from kubernetes_version during cluster upgrades"
  type = string
  default = ""
}

variable blue_node_group_min_size {
  description = "Minimum size of each node group attached to the AWS EKS cluster"
  type = number
  default = 2
}

variable blue_node_group_max_size {
  description = "Maximum size of each node group attached to the AWS EKS cluster"
  type = number
  default = 8
}

variable blue_node_group_desired_size {
  description = "Desired size of each node group attached to the AWS EKS cluster; will default to node_group_min_size if not specified"
  type = number
  default = 0
}

variable blue_node_group_disk_size {
  description = "Disk size of the worker nodes"
  type = number
  default = 100
}

variable blue_node_group_capacity_type {
  description = "Defines the purchasing option for the EC2 instances in all node groups"
  type = string
  default = "SPOT"
}

variable blue_node_group_instance_types {
  description = "list of EC2 instance types which should be used for the AWS EKS worker node groups ordered descending by preference"
  type = list(string)
  default = [ "m5a.large", "m5.large", "m4.large", "t3a.large", "t3.large", "t2.large"]
}

variable green_node_group_enabled {
  description = "controls if the green managed node group should be enabled"
  type = bool
  default = false
}

variable green_node_group_kubernetes_version {
  description = "Kubernetes version of the green node group; will default to kubernetes_version, if not specified but may differ from kubernetes_version during cluster upgrades"
  type = string
  default = ""
}

variable green_node_group_min_size {
  description = "Minimum size of each node group attached to the AWS EKS cluster"
  type = number
  default = 2
}

variable green_node_group_max_size {
  description = "Maximum size of each node group attached to the AWS EKS cluster"
  type = number
  default = 8
}

variable green_node_group_desired_size {
  description = "Desired size of each node group attached to the AWS EKS cluster; will default to node_group_min_size if not specified"
  type = number
  default = 0
}

variable green_node_group_disk_size {
  description = "Disk size of the worker nodes"
  type = number
  default = 100
}

variable green_node_group_capacity_type {
  description = "Defines the purchasing option for the EC2 instances in all node groups"
  type = string
  default = "SPOT"
}

variable green_node_group_instance_types {
  description = "list of EC2 instance types which should be used for the AWS EKS worker node groups ordered descending by preference"
  type = list(string)
  default = [ "m5a.large", "m5.large", "m4.large", "t3a.large", "t3.large", "t2.large"]
}

variable private_endpoint_enabled {
  description = "controls if the communication between worker nodes and control plane nodes should use private connections"
  type = bool
  default = false
}
