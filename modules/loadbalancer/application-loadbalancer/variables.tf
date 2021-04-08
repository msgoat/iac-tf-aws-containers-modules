# variables.tf
# ---------------------------------------------------------------------------
# Defines all input variable for this demo.
# ---------------------------------------------------------------------------

variable region_name {
  description = "The AWS region to deploy into (e.g. eu-central-1)."
  type = string
}

variable solution_name {
  description = "The name of the AWS solution that owns all AWS resources."
  type = string
}

variable solution_stage {
  description = "The name of the current AWS solution stage."
  type = string
}

variable solution_fqn {
  description = "The fully qualified name of the current AWS solution."
  type = string
}

variable common_tags {
  description = "Common tags to be attached to all AWS resources"
  type = map(string)
}

variable loadbalancer_name {
  description = "Logical name of the newly created Application Load Balancer"
  type = string
}

variable vpc_id {
  description = "Unique identifier of the VPC to host the Application Load Balancer"
  type = string
}

variable public_subnet_ids {
  description = "Unique identifiers of all public subnets inside the VPC"
  type = list(string)
}

variable private_subnet_ids {
  description = "Unique identifiers of all private subnets inside the VPC"
  type = list(string)
}

variable host_names {
  description = "DNS domain names of hosts whose traffic should be routed through the Application Load Balancer"
  type = list(string)
}

variable target_group {
  description = "Configuration of the default target group"
  type = object({
    name = string
    port = number
    protocol = string
  })
}

variable target_group_health_check {
  description = "Configuration of the default target group health check"
  type = object({
    path = string
    port = number
    protocol = string
    healthy_threshold = number
    unhealthy_threshold = number
    timeout = number
  })
}

variable inbound_traffic_cidrs {
  description = "IP address ranges which are allowed to send inbound traffic to the Application Loadbalancer"
  type = list(string)
  default = ["0.0.0.0/0"]
}

variable ssl_security_policy {
  description = "Security policy used for the HTTPS listener"
  type = string
  default = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"
}

variable eks_cluster_name {
  description = "Name of an AWS EKS cluster whose managed node groups should be attached to the target groups"
  type = string
}

variable loadbalancer_security_group_id {
  description = "Unique identifier of a security group which allows an external loadbalancer to talk to the ingress controller via node ports"
  type = string
}