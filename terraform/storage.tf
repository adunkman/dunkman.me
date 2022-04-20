# AWS002 — logging is not required for public files
# AWS017 — encryption not needed for public files
# AWS077 — build files do not need to be versioned
#
# tfsec:ignore:AWS002 tfsec:ignore:AWS017 tfsec:ignore:AWS077 tfsec:ignore:aws-s3-block-public-acls tfsec:ignore:aws-s3-block-public-policy tfsec:ignore:aws-s3-ignore-public-acls tfsec:ignore:aws-s3-no-public-buckets tfsec:ignore:aws-s3-encryption-customer-key tfsec:ignore:aws-s3-specify-public-access-block
resource "aws_s3_bucket" "dunkman_me" {
  bucket = "dunkman.me"
  acl = "public-read" # tfsec:ignore:AWS001 — public read is okay for public files

  website {
    index_document = "index.html"
    error_document = "404.html"
  }
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
