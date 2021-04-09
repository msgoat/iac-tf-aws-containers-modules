resource helm_release jaeger {
  chart = "jaeger"
  version = "0.45.0"
  name = var.helm_release_name
  dependency_update = true
  atomic = true
  cleanup_on_fail = true
  namespace = module.namespace.kubernetes_namespace_name
  repository = "https://jaegertracing.github.io/helm-charts"
  values = [file("${path.module}/resources/helm/jaeger/values.yaml")]
  set {
    name = "query.ingress.hosts[0]"
    value = "jaeger.${var.public_dns_zone_name}"
  }
}