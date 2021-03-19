# loadbalancer.tf
#----------------------------------------------------------------------
# creates an Application Loadbalancer in front of the EKS cluster
#----------------------------------------------------------------------
#

locals {
  alb_name = "alb-${var.region_name}-${var.solution_fqn}-${var.loadbalancer_name}"
}

resource aws_lb loadbalancer {
  name = local.alb_name
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.loadbalancer.id]
  subnets = data.aws_subnet_ids.subnet_ids.ids
  tags = merge({ Name = local.alb_name }, local.module_common_tags)
}

# --- listeners

resource aws_lb_listener http {
  load_balancer_arn = aws_lb.loadbalancer.arn
  port = "80"
  protocol = "HTTP"
  default_action {
    type = "redirect"

    redirect {
      port = "443"
      protocol = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource aws_lb_listener https {
  load_balancer_arn = aws_lb.loadbalancer.arn
  port = "443"
  protocol = "HTTPS"
  ssl_policy = var.ssl_security_policy
  certificate_arn = aws_acm_certificate.cert.arn

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.ingress.arn
  }
}

