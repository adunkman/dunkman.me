resource "aws_route53_record" "home" {
  zone_id = aws_route53_zone.primary.zone_id
  name = "home.dunkman.me"
  type = "CNAME"
  ttl = 30

  records = [
    "xgbkjbsscyckhpn2jmr86ypwz4eduopl.ui.nabu.casa"
  ]
}


resource "aws_route53_record" "home_challenge" {
  zone_id = aws_route53_zone.primary.zone_id
  name = "_acme-challenge.home.dunkman.me"
  type = "CNAME"
  ttl = 30

  records = [
    "_acme-challenge.xgbkjbsscyckhpn2jmr86ypwz4eduopl.ui.nabu.casa"
  ]
}
