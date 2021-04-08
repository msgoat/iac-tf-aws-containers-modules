variable region_name {
  description = "The AWS region to deploy into."
  type = string
}

variable common_tags {
  description = "Map of common tags to be attached to all managed AWS resources"
  type = map(string)
}

variable solution_name {
  description = "Name of this AWS solution"
  type = string
}

variable solution_stage {
  description = "Stage of this AWS solution (like DEV, QA, PROD)"
  type = string
}

variable solution_fqn {
  description = "Fully qualified name of this AWS solution"
  type = string
}

variable kube_config_file_name {
  description = "defines the location the kubeconfig file for the newly created cluster should be written to"
  type = string
}

variable kubernetes_namespace_name {
  description = "name of the Kubernetes namespace to create"
  type = string
}

variable istio_injection_enabled {
  description = "controls if Istio sidecar injection should be enabled on this namespace"
  type = bool
  default = false
}

variable network_policy_enforced {
  description = "adds a network policy blocking any inbound traffic, thus enforcing each deployment to provide a network policy"
  type = bool
  default = true
}
