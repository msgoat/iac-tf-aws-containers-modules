resource helm_release nexus {
  chart = "nexus-repository-manager"
  version = "29.2.0"
  name = var.helm_release_name
  dependency_update = true
  atomic = true
  cleanup_on_fail = true
  namespace = module.namespace.kubernetes_namespace_name
  repository = "https://sonatype.github.io/helm3-charts/"
  values = [file("${path.module}/resources/helm/nexus-repository-manager/values.yaml")]
  set {
    name = "ingress.hostRepo"
    value = "nexus.${var.public_dns_zone_name}"
  }
}