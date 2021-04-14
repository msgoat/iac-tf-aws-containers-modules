resource random_string drone_admin_user {
  length = 16
  special = false
}

resource random_password drone_admin_password {
  length = 20
  special = true
}

resource kubernetes_secret drone_admin {
  type = "Opaque"
  metadata {
    name = "drone-admin"
    namespace = module.namespace.kubernetes_namespace_name
    labels = {
      "app.kubernetes.io/name" = "drone-admin"
      "app.kubernetes.io/instance" = "drone-admin"
      "app.kubernetes.io/managed-by" = "Terraform"
      "app.kubernetes.io/part-of" = "drone"
    }
  }
  data = {
    DRONE_USER_CREATE = "username:${random_string.drone_admin_user.result},machine:false,admin:true,token:${random_password.drone_admin_password.result}"
  }
}