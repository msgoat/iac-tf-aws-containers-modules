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
KUBECONFIG
}
