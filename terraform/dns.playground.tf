resource "aws_route53_record" "playground" {
  zone_id = aws_route53_zone.primary.zone_id
  name = "playground.dunkman.me"
  type = "NS"
  ttl = 30

  records = [
    "ns-1458.awsdns-54.org",
    "ns-3.awsdns-00.com",
    "ns-1829.awsdns-36.co.uk",
    "ns-921.awsdns-51.net"
  ]
}
