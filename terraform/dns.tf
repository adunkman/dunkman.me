resource "aws_route53_zone" "primary" {
  name = "dunkman.me"
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "www.dunkman.me"
  type    = "A"

  alias {
    name = aws_cloudfront_distribution.dunkman_me.domain_name
    zone_id = aws_cloudfront_distribution.dunkman_me.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "apex" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "dunkman.me"
  type    = "A"

  alias {
    name = aws_cloudfront_distribution.redirect_to_dunkman_me.domain_name
    zone_id = aws_cloudfront_distribution.redirect_to_dunkman_me.hosted_zone_id
    evaluate_target_health = false
  }
}
