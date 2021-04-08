resource helm_release elasticsearch {
  chart = "elasticsearch"
  version = "7.12.0"
  repository = "https://helm.elastic.co"
  name = var.helm_release_name
  dependency_update = true
  atomic = true
  cleanup_on_fail = true
  namespace = var.kubernetes_namespace_name
  values = [file("${path.module}/resources/helm/elasticsearch/values.yaml")]
  set {
    name = "clusterName"
    value = var.elasticsearch_cluster_name
  }
  set {
    name = "volumeClaimTemplate.resources.requests.storage"
    value = var.elasticsearch_storage_size
  }
}