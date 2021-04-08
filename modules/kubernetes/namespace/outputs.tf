output kubernetes_namespace_name {
  description = "Name of the newly created Kubernetes namespace"
  value = kubernetes_namespace.namespace.metadata[0].name
}