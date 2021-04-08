resource helm_release autoscaler {
  chart = "${path.module}/resources/helm/cluster-autoscaler"
  name = "cluster-autoscaler"
  dependency_update = true
  atomic = true
  cleanup_on_fail = true
  namespace = "kube-system"
  set {
    name = "cluster.name"
    value = aws_eks_cluster.control_plane.name
  }
}