resource "aws_acm_certificate" "dunkman_me" {
  domain_name = "*.dunkman.me"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "dunkman_me_validation" {
  for_each = {
    for dvo in aws_acm_certificate.dunkman_me.domain_validation_options : dvo.domain_name => {
      name = dvo.resource_record_name
      record = dvo.resource_record_value
      type = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name = each.value.name
  records = [each.value.record]
  ttl = 60
  type = each.value.type
  zone_id = aws_route53_zone.primary.zone_id
}

resource "aws_acm_certificate_validation" "dunkman_me" {
  certificate_arn = aws_acm_certificate.dunkman_me.arn
  validation_record_fqdns = [for record in aws_route53_record.dunkman_me_validation : record.fqdn]
}
