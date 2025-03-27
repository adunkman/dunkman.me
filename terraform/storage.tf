# tfsec:ignore:aws-s3-enable-bucket-encryption
# tfsec:ignore:aws-s3-encryption-customer-key
# tfsec:ignore:aws-s3-enable-bucket-logging
# tfsec:ignore:aws-s3-enable-versioning
resource "aws_s3_bucket" "dunkman_me" {
  bucket = "dunkman.me"
}

resource "aws_s3_bucket_website_configuration" "dunkman_me" {
  bucket = aws_s3_bucket.dunkman_me.id
  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "404.html"
  }
}

resource "aws_s3_bucket_ownership_controls" "dunkman_me" {
  bucket = aws_s3_bucket.dunkman_me.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "dunkman_me" {
  bucket = aws_s3_bucket.dunkman_me.id

  block_public_acls = false # tfsec:ignore:aws-s3-block-public-acls
  block_public_policy = false # tfsec:ignore:aws-s3-block-public-policy
  ignore_public_acls = false # tfsec:ignore:aws-s3-ignore-public-acls
  restrict_public_buckets = false # tfsec:ignore:aws-s3-no-public-buckets
}

resource "aws_s3_bucket_acl" "dunkman_me" {
  depends_on = [
    aws_s3_bucket_ownership_controls.dunkman_me,
    aws_s3_bucket_public_access_block.dunkman_me,
  ]

  bucket = aws_s3_bucket.dunkman_me.id
  acl = "public-read" # tfsec:ignore:aws-s3-no-public-access-with-acl
}

resource "aws_s3_bucket_policy" "dunkman_me" {
  bucket = aws_s3_bucket.dunkman_me.id
  policy = data.aws_iam_policy_document.allow_public_read.json
}

data "aws_iam_policy_document" "allow_public_read" {
  statement {
    actions = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.dunkman_me.arn}/*"]
    principals {
      type = "*"
      identifiers = ["*"]
    }
  }
}
