resource "aws_route53_record" "inclusion-bot" {
  zone_id = aws_route53_zone.primary.zone_id
  name = "inclusion-bot.dunkman.me"
  type = "CNAME"
  ttl = 30

  records = [
    "environmental-anteater-rv79rftefdaio0l12976en28.herokudns.com"
  ]
}
