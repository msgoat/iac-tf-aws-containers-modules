# --- kubeconfig -----------------------------------------------------------------

locals {
  kube_config = <<KUBECONFIG
apiVersion: v1
clusters:
- cluster:
    server: ${aws_eks_cluster.control_plane.endpoint}
    certificate-authority-data: ${aws_eks_cluster.control_plane.certificate_authority.0.data}
  name: ${aws_eks_cluster.control_plane.name}
contexts:
- context:
    cluster: ${aws_eks_cluster.control_plane.name}
    user: aws
  name: aws@${aws_eks_cluster.control_plane.name}
current-context: aws
kind: Config
preferences: {}
users:
- name: aws@${aws_eks_cluster.control_plane.name}
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      command: aws-iam-authenticator
      args:
      - "token"
      - "-i"
      - "${aws_eks_cluster.control_plane.name}"
      env:
      - name: AWS_STS_REGIONAL_ENDPOINTS
        value: regional
      - name: AWS_DEFAULT_REGION
        value: ${var.region_name}

KUBECONFIG

  generated_kube_config_filename = "${local.eks_cluster_name}.yaml"
  normalized_kube_config_dirname = trimsuffix(var.kube_config_file_dir, "/")
  kube_config_filename = "${local.normalized_kube_config_dirname}/${local.generated_kube_config_filename}"
}

resource local_file kube_config {
  filename = local.kube_config_filename
  content = local.kube_config
}