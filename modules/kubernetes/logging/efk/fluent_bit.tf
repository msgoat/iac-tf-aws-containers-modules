resource helm_release fluent_bit {
  chart = "fluent-bit"
  version = "0.15.4"
  name = "fluent-bit"
  dependency_update = true
  atomic = true
  cleanup_on_fail = true
  namespace = module.namespace.kubernetes_namespace_name
  repository = "https://fluent.github.io/helm-charts"
  values = [templatefile("${path.module}/resources/helm/fluent-bit/values.template.yaml", {
    tf_cluster_name = var.eks_cluster_name
    tf_elasticsearch_host = module.elasticsearch.elasticsearch_service_name
    tf_elasticsearch_port = module.elasticsearch.elasticsearch_service_port
  })]
}