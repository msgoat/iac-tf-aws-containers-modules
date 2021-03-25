output kube_config_file_name {
  description = "Full pathname of the Kubernetes configuration file to access this AWS EKS cluster"
  value = module.cluster.kube_config_file_name
}