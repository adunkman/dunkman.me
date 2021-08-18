resource "aws_route53_record" "static-site-with-preview-builds" {
  zone_id = aws_route53_zone.primary.zone_id
  name = "static-site-with-preview-builds.dunkman.me"
  type = "NS"
  ttl = 30

  records = [
    "ns-1583.awsdns-05.co.uk.",
    "ns-400.awsdns-50.com.",
    "ns-1063.awsdns-04.org.",
    "ns-675.awsdns-20.net.",
  ]
}
