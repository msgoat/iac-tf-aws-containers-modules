resource null_resource wait_for_eksctl_config {
  triggers = {
    eksctl_config_file_id = local_file.eksctl_config_at_dirname.id
  }
  provisioner local-exec {
    command = "eksctl create cluster -f ${local_file.eksctl_config_at_dirname.filename} --kubeconfig ${local.kube_config_filename}"
  }
}