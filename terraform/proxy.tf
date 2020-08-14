locals {
  s3_origin_id = "dunkman_me"
}

resource "aws_cloudfront_distribution" "dunkman_me" {
  enabled = true
  is_ipv6_enabled = true
  default_root_object = "index.html"

  aliases = [ "staging.dunkman.me" ]

  custom_error_response {
    error_caching_min_ttl = 3600
    error_code = 404
    response_code = 404
    response_page_path = "/404.html"
  }

  origin {
    domain_name = aws_s3_bucket.dunkman_me.bucket_regional_domain_name
    origin_id = local.s3_origin_id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.dunkman_me.cloudfront_access_identity_path
    }
  }

  default_cache_behavior {
    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    compress = true
  }

  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.dunkman_me.arn
    minimum_protocol_version = "TLSv1.2_2018"
    ssl_support_method = "sni-only"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}

resource "aws_cloudfront_origin_access_identity" "dunkman_me" {
}

resource "aws_s3_bucket_policy" "dunkman_me" {
  bucket = aws_s3_bucket.dunkman_me.id
  policy = data.aws_iam_policy_document.s3_policy.json
}

data "aws_iam_policy_document" "s3_policy" {
  statement {
    actions = [
      "s3:HeadBucket",
      "s3:ListBucket",
      "s3:GetObject",
    ]

    resources = ["${aws_s3_bucket.dunkman_me.arn}/*"]

    principals {
      type = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.dunkman_me.iam_arn]
    }
  }
}
