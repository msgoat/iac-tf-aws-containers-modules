resource helm_release metrics_server {
  chart = "${path.module}/resources/helm/metrics-server"
  name = "metrics-server"
  dependency_update = true
  atomic = true
  cleanup_on_fail = true
  namespace = "kube-system"
}