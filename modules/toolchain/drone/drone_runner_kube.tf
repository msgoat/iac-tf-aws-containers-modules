resource helm_release drone_runner_kube {
  chart = "drone-runner-kube"
  version = "0.1.5"
  name = "drone-runner-kube"
  dependency_update = true
  atomic = true
  cleanup_on_fail = true
  namespace = module.namespace.kubernetes_namespace_name
  repository = "https://charts.drone.io"
  values = [file("${path.module}/resources/helm/drone-runner-kube/values.yaml")]
  set {
    name = "rbac.buildNamespaces[0]"
    value = module.namespace.kubernetes_namespace_name
  }
  set {
    name = "env.DRONE_NAMESPACE_DEFAULT"
    value = module.namespace.kubernetes_namespace_name
  }
  depends_on = [
    kubernetes_secret.drone_rpc
  ]
}