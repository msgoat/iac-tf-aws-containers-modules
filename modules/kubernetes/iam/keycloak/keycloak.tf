resource helm_release keycloak {
  chart = "keycloak"
  version = "10.1.0"
  repository = "https://codecentric.github.io/helm-charts"
  name = var.helm_release_name
  dependency_update = true
  atomic = true
  cleanup_on_fail = true
  namespace = module.namespace.kubernetes_namespace_name
  values = [file("${path.module}/resources/helm/keycloak/values.yaml")]
  set {
    name = "ingress.rules[0].host"
    value = "iam.${var.public_dns_zone_name}"
  }
}