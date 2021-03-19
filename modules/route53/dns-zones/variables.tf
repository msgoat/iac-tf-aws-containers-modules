# variables.tf
# ---------------------------------------------------------------------------
# Defines all input variables for this module.
# ---------------------------------------------------------------------------

variable "region_name" {
  description = "The AWS region to deploy into (e.g. eu-central-1)."
  type = string
}

variable common_tags {
  description = "Common tags to be attached to all AWS resources"
  type = map(string)
}

variable "solution_name" {
  description = "The name of the solution that owns all AWS resources."
  type = string
}

variable "solution_stage" {
  description = "The name of the current solution stage."
  type = string
}

variable "solution_fqn" {
  description = "The fully qualified name of the current AWS solution."
  type = string
}

variable public_root_domain_name {
  description = "The name of the public root domain"
  type = string
}