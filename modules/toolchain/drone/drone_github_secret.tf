resource kubernetes_secret drone_github {
  type = "Opaque"
  metadata {
    name = "drone-github"
    namespace = module.namespace.kubernetes_namespace_name
    labels = {
      "app.kubernetes.io/name" = "drone-github"
      "app.kubernetes.io/instance" = "drone-github"
      "app.kubernetes.io/managed-by" = "Terraform"
      "app.kubernetes.io/part-of" = "drone"
   }
  }
  data = {
    DRONE_GITHUB_CLIENT_ID: var.github_client_id
    DRONE_GITHUB_CLIENT_SECRET: var.github_client_secret
  }
}