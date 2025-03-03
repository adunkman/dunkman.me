resource "aws_route53_record" "bluesky" {
  zone_id = aws_route53_zone.primary.zone_id
  name = "_atproto.dunkman.me"
  type = "TXT"
  ttl = 30

  records = [
    "did=did:plc:zjyqa2ak7zz3syhorp54mjcq"
  ]
}
