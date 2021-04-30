resource helm_release kube_prometheus_stack {
  chart = "kube-prometheus-stack"
  version = "15.2.0"
  name = var.helm_release_name
  dependency_update = true
  atomic = true
  cleanup_on_fail = true
  namespace = module.namespace.kubernetes_namespace_name
  repository = "https://prometheus-community.github.io/helm-charts"
  values = [file("${path.module}/resources/helm/kube-prometheus-stack/values.yaml")]
  set {
    name = "grafana.ingress.hosts[0]"
    value = "grafana.${var.public_dns_zone_name}"
  }
}