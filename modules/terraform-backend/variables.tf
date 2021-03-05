# variables.tf
# ---------------------------------------------------------------------------
# Defines all input variable for this demo.
# ---------------------------------------------------------------------------

variable "region_name" {
  description = "The AWS region to deploy into (e.g. eu-central-1)."
  type = string
}

variable "organization_name" {
  description = "The name of the organization that owns all AWS resources."
  type = string
}

variable "department_name" {
  description = "The name of the department that owns all AWS resources."
  type = string
}

variable "solution_name" {
  description = "The name of the solution that owns all AWS resources."
  type = string
}

variable "solution_stage" {
  description = "The name of the current solution stage."
  type = string
}
