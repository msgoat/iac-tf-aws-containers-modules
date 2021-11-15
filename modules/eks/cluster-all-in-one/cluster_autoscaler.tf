resource helm_release autoscaler {
  chart = "cluster-autoscaler"
  name = "cluster-autoscaler"
  version = "9.10.7"
  repository = "https://kubernetes.github.io/autoscaler"
  dependency_update = true
  atomic = true
  cleanup_on_fail = true
  namespace = "kube-system"
  set {
    name = "autoDiscovery.clusterName"
    value = aws_eks_cluster.control_plane.name
  }
}