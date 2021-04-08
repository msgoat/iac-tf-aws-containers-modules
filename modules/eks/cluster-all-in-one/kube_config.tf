# --- kubeconfig -----------------------------------------------------------------

locals {
  kube_config = <<KUBECONFIG
apiVersion: v1
clusters:
- cluster:
    server: ${aws_eks_cluster.control_plane.endpoint}
    certificate-authority-data: ${aws_eks_cluster.control_plane.certificate_authority.0.data}
  name: ${aws_eks_cluster.control_plane.arn}
contexts:
- context:
    cluster: ${aws_eks_cluster.control_plane.arn}
    user: ${aws_eks_cluster.control_plane.arn}
  name: ${aws_eks_cluster.control_plane.arn}
current-context: ${aws_eks_cluster.control_plane.arn}
kind: Config
preferences: {}
users:
- name: ${aws_eks_cluster.control_plane.arn}
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      args:
      - --region
      - ${var.region_name}
      - eks
      - get-token
      - --cluster-name
      - ${aws_eks_cluster.control_plane.name}
      command: aws
      env:
      - name: AWS_PROFILE
        value: ${var.aws_profile_name}
KUBECONFIG

  generated_kube_config_filename = "${local.eks_cluster_name}.yaml"
  normalized_kube_config_dirname = trimsuffix(var.kube_config_file_dir, "/")
  kube_config_filename = "${local.normalized_kube_config_dirname}/${local.generated_kube_config_filename}"
}

resource local_file kube_config {
  filename = local.kube_config_filename
  content = local.kube_config
}