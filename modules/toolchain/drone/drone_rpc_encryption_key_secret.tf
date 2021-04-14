resource random_password drone_rpc {
  length = 20
  special = false
}

resource kubernetes_secret drone_rpc {
  type = "Opaque"
  metadata {
    name = "drone-rpc"
    namespace = module.namespace.kubernetes_namespace_name
    labels = {
      "app.kubernetes.io/name" = "drone-rpc"
      "app.kubernetes.io/instance" = "drone-rpc"
      "app.kubernetes.io/managed-by" = "Terraform"
      "app.kubernetes.io/part-of" = "drone"
    }
  }
  data = {
    DRONE_RPC_SECRET = random_password.drone_rpc.result
  }
}