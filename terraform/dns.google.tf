resource "aws_route53_record" "google_search" {
  zone_id = aws_route53_zone.primary.zone_id
  name = "dunkman.me"
  type = "TXT"
  ttl = 30

  records = [
    "google-site-verification=4-mwbACOYyC96Fxd1bZIPp0lgI4Cwm8dibHYLmJ7NmU"
  ]
}
