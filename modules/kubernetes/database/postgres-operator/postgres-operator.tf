resource helm_release postgres_operator {
  chart = "${path.module}/resources/helm/charts/postgres-operator"
  version = "1.6.2"
  name = var.helm_release_name
  dependency_update = true
  atomic = true
  cleanup_on_fail = true
  namespace = var.kubernetes_namespace_name
  values = [file("${path.module}/resources/helm/postgres-operator/values.yaml")]
  set {
    name = "configAwsOrGcp.aws_region"
    value = var.region_name
  }
}