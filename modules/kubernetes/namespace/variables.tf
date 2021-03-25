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


variable kube_config_filename {
  description = "defines the location the kubeconfig file for the newly created cluster should be written to"
  type = string
}

variable kubernetes_namespaces {
  description = "list of configuration parameters per Kubernetes namespace to create"
  type = list(object({
    namespace_name: string
    istio_injection_enabled: bool
    network_policy_enforced: bool
  }))
}
