locals {
  s3_origin_id = "dunkman_me"
}

# AWS045 — firewall is not needed to protect S3
# AWS071 — access logging is not required for public files
#
# tfsec:ignore:AWS045 tfsec:ignore:AWS071
resource "aws_cloudfront_distribution" "dunkman_me" {
  enabled = true
  is_ipv6_enabled = true
  default_root_object = "index.html"

  aliases = [ "www.dunkman.me" ]

  custom_error_response {
    error_caching_min_ttl = 3600
    error_code = 404
    response_code = 404
    response_page_path = "/404.html"
  }

  origin {
    domain_name = aws_s3_bucket.dunkman_me.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.dunkman_me.id
    origin_id = local.s3_origin_id
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

  ordered_cache_behavior {
    path_pattern     = "/christmas-letters/*"
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

    lambda_function_association {
      event_type = "viewer-request"
      lambda_arn = aws_lambda_function.authenticator.qualified_arn
    }
  }

  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.dunkman_me.arn
    minimum_protocol_version = "TLSv1.2_2021"
    ssl_support_method = "sni-only"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}

resource "aws_cloudfront_origin_access_control" "dunkman_me" {
  name = aws_s3_bucket.dunkman_me.bucket
  origin_access_control_origin_type = "s3"
  signing_behavior = "always"
  signing_protocol = "sigv4"
}
