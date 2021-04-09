resource aws_route53_record jaeger {
  name = "jaeger.${var.public_dns_zone_name}"
  type = "A"
  zone_id = data.aws_route53_zone.host.id

  alias {
    name = data.aws_lb.loadbalancer.dns_name
    zone_id = data.aws_lb.loadbalancer.zone_id
    evaluate_target_health = false
  }
}
