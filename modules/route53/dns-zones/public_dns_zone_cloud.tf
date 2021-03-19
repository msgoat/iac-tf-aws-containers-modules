resource aws_route53_zone public_cloud {
  name = "aws.${var.public_root_domain_name}"
  tags = merge({Name = "dnsz-${var.solution_fqn}-public-cloud"}, local.module_common_tags)
}

# create NS record with nameservers of newly created zone in subdomain zone
resource aws_route53_record public_cloud_nameservers  {
  zone_id = data.aws_route53_zone.public_root.id
  name = aws_route53_zone.public_cloud.name
  type = "NS"
  records = [for ns in aws_route53_zone.public_cloud.name_servers : "${ns}."]
  ttl = 3600
}