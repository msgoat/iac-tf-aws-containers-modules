resource random_password drone_db_encrypt {
  length = 32
  special = false
}

resource kubernetes_secret drone_db_encrypt {
  type = "Opaque"
  metadata {
    name = "drone-encryption"
    namespace = module.namespace.kubernetes_namespace_name
    labels = {
      "app.kubernetes.io/name" = "drone-encryption"
      "app.kubernetes.io/instance" = "drone-encryption"
      "app.kubernetes.io/managed-by" = "Terraform"
      "app.kubernetes.io/part-of" = "drone"
    }
  }
  data = {
    DRONE_DATABASE_SECRET = random_password.drone_db_encrypt.result
  }
}