resource helm_release kibana {
  chart = "kibana"
  version = "7.12.0"
  repository = "https://helm.elastic.co"
  name = "kibana"
  dependency_update = true
  atomic = true
  cleanup_on_fail = true
  namespace = var.kubernetes_namespace_name
  values = [file("${path.module}/resources/helm/kibana/values.yaml")]
  set {
    name = "elasticsearchHosts"
    value = "http://${module.elasticsearch.elasticsearch_service_name}:${module.elasticsearch.elasticsearch_service_port}"
  }
  set {
    name = "ingress.hosts[0].host"
    value = "kibana.${var.public_dns_zone_name}"
  }
}