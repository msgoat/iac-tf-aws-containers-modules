output application_dns {
  description = "DNS name of the given application"
  value = aws_route53_record.application.name
}

