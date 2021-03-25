provider aws {
  region = "eu-west-1"
}

module cluster {
  source = "../../modules/eks/cluster-all-in-one"
  region_name = "eu-west-1"
  solution_name = "cloudtrain"
  solution_stage = "DEV"
  solution_fqn = "cloudtrain-dev"
  kubernetes_cluster_name = "terraform"
  common_tags = {
    "Organization" = "msg systems AG"
    "Department" = "Automotive Technology"
    "ManagedBy" = "Terraform"
    "PartOf" = "CloudTrain"
    "Solution" = "cloudtrain"
    "Stage" = "dev"
  }
  inbound_traffic_cidrs = [ "0.0.0.0/0" ] # ["84.186.251.120/32"]
  network_cidr = "10.17.0.0/16"
  node_group_min_size = 1
  node_group_max_size = 3
  zones_to_span = 2
  blue_node_group_enabled = true
  private_endpoint_enabled = true
  kube_config_file_dir = "../../target/.kube"
}