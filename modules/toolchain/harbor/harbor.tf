resource helm_release harbor {
  chart = "harbor"
  version = "1.6.1"
  name = var.helm_release_name
  dependency_update = true
  atomic = true
  cleanup_on_fail = true
  namespace = module.namespace.kubernetes_namespace_name
  repository = "https://helm.goharbor.io"
  values = [file("${path.module}/resources/helm/harbor/values.yaml")]
  set {
    name = "expose.ingress.hosts.core"
    value = "docker.${var.public_dns_zone_name}"
  }
  set {
    name = "expose.ingress.hosts.notary"
    value = "notary.${var.public_dns_zone_name}"
  }
  set {
    name = "externalURL"
    value = "https://docker.${var.public_dns_zone_name}"
  }
  set {
    name = "persistence.imageChartStorage.s3.region"
    value = aws_s3_bucket.backend.region
  }
  set {
    name = "persistence.imageChartStorage.s3.bucket"
    value = aws_s3_bucket.backend.bucket
  }
  set {
    name = "persistence.imageChartStorage.s3.accesskey"
    value = aws_iam_access_key.harbor.id
  }
  set {
    name = "persistence.imageChartStorage.s3.secretkey"
    value = aws_iam_access_key.harbor.secret
  }
  set {
    name = "database.external.host"
    value = module.postgresql.db_host_name
  }
  set {
    name = "database.external.port"
    value = module.postgresql.db_port_number
  }
  set {
    name = "database.external.username"
    value = module.postgresql.db_user_name
  }
  set {
    name = "database.external.password"
    value = module.postgresql.db_user_password
  }
}