output eksctl_config {
  value = local.eksctl_config
}

output eksctl_config_file_name {
  description = "Full pathname of the generated eksctk configuration file"
  value = local_file.eksctl_config_at_dirname.filename
}
