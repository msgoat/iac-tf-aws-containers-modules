output kube_config {
  description = "Kubernetes configuration file to access this AWS EKS cluster"
  value = local.kube_config
}