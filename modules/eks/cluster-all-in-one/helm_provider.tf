provider helm {
  kubernetes {
    host                   = aws_eks_cluster.control_plane.endpoint
    cluster_ca_certificate = base64decode(aws_eks_cluster.control_plane.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.control_plane.token
  }
}