resource helm_release drone {
  chart = "drone"
  version = "0.1.7"
  name = var.helm_release_name
  dependency_update = true
  atomic = true
  cleanup_on_fail = true
  namespace = module.namespace.kubernetes_namespace_name
  repository = "https://charts.drone.io"
  values = [file("${path.module}/resources/helm/drone/values.yaml")]
  set {
    name = "ingress.hosts[0].host"
    value = "drone.${var.public_dns_zone_name}"
  }
  set {
    name = "env.DRONE_SERVER_HOST"
    value = "drone.${var.public_dns_zone_name}"
  }
  depends_on = [
    kubernetes_secret.drone_admin,
    kubernetes_secret.drone_db,
    kubernetes_secret.drone_db_encrypt,
    kubernetes_secret.drone_github,
    kubernetes_secret.drone_rpc,
    kubernetes_secret.drone_s3
  ]
}