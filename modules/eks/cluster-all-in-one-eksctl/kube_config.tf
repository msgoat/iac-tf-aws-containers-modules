locals {
  generated_kube_config_filename = "${local.eks_cluster_name}.yaml"
  normalized_kube_config_dirname = trimsuffix(var.kube_config_file_dir, "/")
  kube_config_filename = "${local.normalized_kube_config_dirname}/${local.generated_kube_config_filename}"
}