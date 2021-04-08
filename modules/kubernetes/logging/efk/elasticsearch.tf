module elasticsearch {
  source = "../../../kubernetes/database/elasticsearch"
  region_name = var.region_name
  solution_name = var.solution_name
  solution_stage = var.solution_stage
  solution_fqn = var.solution_fqn
  common_tags = local.module_common_tags
  kube_config_file_name = var.kube_config_file_name
  kubernetes_namespace_name = var.kubernetes_namespace_name
  elasticsearch_cluster_name = "es-logging"
  elasticsearch_storage_size = "50Gi"
}