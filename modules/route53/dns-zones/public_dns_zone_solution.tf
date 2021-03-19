resource aws_route53_zone public_solution {
  name = "${var.solution_name}.${aws_route53_zone.public_cloud.name}"
  tags = merge({Name = "dnsz-${var.solution_fqn}-public-solution"}, local.module_common_tags)
}

# create NS record with nameservers of newly created zone in subdomain zone
resource aws_route53_record public_solution_nameservers  {
  zone_id = aws_route53_zone.public_cloud.id
  name = aws_route53_zone.public_solution.name
  type = "NS"
  records = [for ns in aws_route53_zone.public_solution.name_servers : "${ns}."]
  ttl = 3600
}