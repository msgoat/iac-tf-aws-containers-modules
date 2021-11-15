resource helm_release aws_loadbalancer_controller {
  name = "aws-load-balancer-controller"
  chart = "aws-load-balancer-controller"
  version = "1.3.2"
  dependency_update = true
  atomic = true
  cleanup_on_fail = true
  namespace = "kube-system"
  repository = "https://aws.github.io/eks-charts"
  set {
    name = "replicaCount"
    value = "2"
  }
  set {
    name = "clusterName"
    value = aws_eks_cluster.control_plane.name
  }
  set {
    name = "podDisruptionBudget.maxUnavailable"
    value = "1"
  }
}