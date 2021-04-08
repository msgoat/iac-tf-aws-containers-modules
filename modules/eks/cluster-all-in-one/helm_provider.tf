provider helm {
  kubernetes {
    config_path = local_file.kube_config.filename
#    host = aws_eks_cluster.control_plane.endpoint
#    cluster_ca_certificate = aws_eks_cluster.control_plane.certificate_authority.0.data
#    insecure = true
#    exec {
#      api_version = "client.authentication.k8s.io/v1alpha1"
#      command = "aws"
#      args = [
#        "--region", var.region_name,
#        "eks", "get-token",
#        "--cluster-name", aws_eks_cluster.control_plane.name]
#      env = {
#        AWS_PROFILE = var.aws_profile_name
#      }
#    }
  }
}