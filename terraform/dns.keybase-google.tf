resource "aws_route53_record" "keybase" {
  zone_id = aws_route53_zone.primary.zone_id
  name = "dunkman.me"
  type = "TXT"
  ttl = 30

  records = [
    "keybase-site-verification=J4ssaE1QoQ1Vtvklt-bxGO7zsumWvF45LqZJFEa4zuQ",
    "google-site-verification=4-mwbACOYyC96Fxd1bZIPp0lgI4Cwm8dibHYLmJ7NmU"
  ]
}
