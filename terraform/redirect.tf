# tfsec:ignore:aws-s3-enable-bucket-encryption
# tfsec:ignore:aws-s3-encryption-customer-key
# tfsec:ignore:aws-s3-enable-bucket-logging
# tfsec:ignore:aws-s3-enable-versioning
resource "aws_s3_bucket" "redirect_to_dunkman_me" {
  bucket = "redirect.dunkman.me"
}

resource "aws_s3_bucket_website_configuration" "redirect_to_dunkman_me" {
  bucket = aws_s3_bucket.redirect_to_dunkman_me.id

  redirect_all_requests_to {
    host_name = "www.dunkman.me"
    protocol = "https"
  }
}

resource "aws_s3_bucket_ownership_controls" "redirect_to_dunkman_me" {
  bucket = aws_s3_bucket.redirect_to_dunkman_me.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "redirect_to_dunkman_me" {
  bucket = aws_s3_bucket.redirect_to_dunkman_me.id

  block_public_acls = false # tfsec:ignore:aws-s3-block-public-acls
  block_public_policy = false # tfsec:ignore:aws-s3-block-public-policy
  ignore_public_acls = false # tfsec:ignore:aws-s3-ignore-public-acls
  restrict_public_buckets = false # tfsec:ignore:aws-s3-no-public-buckets
}

resource "aws_s3_bucket_acl" "redirect_to_dunkman_me" {
  depends_on = [
    aws_s3_bucket_ownership_controls.redirect_to_dunkman_me,
    aws_s3_bucket_public_access_block.redirect_to_dunkman_me,
  ]

  bucket = aws_s3_bucket.redirect_to_dunkman_me.id
  acl = "public-read" # tfsec:ignore:aws-s3-no-public-access-with-acl
}

resource "aws_s3_bucket_policy" "redirect_to_dunkman_me" {
  bucket = aws_s3_bucket.redirect_to_dunkman_me.id
  policy = data.aws_iam_policy_document.allow_public_read_for_redirect_to_dunkman_me.json
}

data "aws_iam_policy_document" "allow_public_read_for_redirect_to_dunkman_me" {
  statement {
    actions = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.redirect_to_dunkman_me.arn}/*"]
    principals {
      type = "*"
      identifiers = ["*"]
    }
  }
}

locals {
  redirect_s3_origin_id = "redirect_to_dunkman_me"
}

# AWS045 — firewall is not needed to protect S3
# AWS071 — access logging is not required for public files
#
# tfsec:ignore:AWS045 tfsec:ignore:AWS071
resource "aws_cloudfront_distribution" "redirect_to_dunkman_me" {
  enabled = true
  is_ipv6_enabled = true

  aliases = [ "dunkman.me" ]

  origin {
    domain_name = aws_s3_bucket_website_configuration.redirect_to_dunkman_me.website_endpoint
    origin_id = local.redirect_s3_origin_id

    custom_origin_config {
      http_port = 80
      https_port = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols = ["TLSv1.2"]
    }
  }

  default_cache_behavior {
    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = local.redirect_s3_origin_id

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
    minimum_protocol_version = "TLSv1.2_2021"
    ssl_support_method = "sni-only"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}
