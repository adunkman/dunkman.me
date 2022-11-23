resource "aws_route53_record" "squad" {
  zone_id = aws_route53_zone.primary.zone_id
  name = "squad.dunkman.me"
  type = "NS"
  ttl = 1800

  records = [
    "ns1.digitalocean.com",
    "ns2.digitalocean.com",
    "ns3.digitalocean.com"
  ]
}
