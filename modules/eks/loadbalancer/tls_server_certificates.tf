# certificate.tf
#----------------------------------------------------------------
# creates a SSL certificate for HTTPS communication
#----------------------------------------------------------------
#

locals {
  non_wildcard_host_names = [for s in var.host_names : s if s == trimprefix(s, "*.")]
  wildcard_host_names = [for s in var.host_names : s if s != trimprefix(s, "*.")]
  domain_name = local.non_wildcard_host_names[0]
  subject_alternative_names = length(var.host_names) > 1 ? slice(var.host_names, 1, length(var.host_names)) : []
}

resource aws_acm_certificate cert {
  domain_name = local.domain_name
  subject_alternative_names = local.subject_alternative_names
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = merge({ Name = "cert-${var.region_name}-${var.solution_fqn}-alb-${var.loadbalancer_name}"}, local.module_common_tags)
}

data aws_route53_zone hosted_zone {
  count = length(local.non_wildcard_host_names)
  name = local.non_wildcard_host_names[count.index]
  private_zone = false
}

resource aws_route53_record cert_validation {
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }
  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.hosted_zone[0].zone_id
}

resource aws_acm_certificate_validation cert {
  count = length(local.non_wildcard_host_names)
  certificate_arn = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for rec in aws_route53_record.cert_validation : rec.fqdn]
}

