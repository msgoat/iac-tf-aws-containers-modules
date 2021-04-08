resource helm_release traefik {
  chart = "traefik"
  version = "9.18.1"
  name = var.helm_release_name
  dependency_update = true
  atomic = true
  cleanup_on_fail = true
  namespace = var.kubernetes_namespace_name
  repository = "https://helm.traefik.io/traefik"
  values = [file("${path.module}/resources/helm/traefik/values.yaml")]
}