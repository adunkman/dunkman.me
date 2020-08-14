resource "aws_s3_bucket" "dunkman_me" {
  bucket = "dunkman.me"
  acl = "public-read"

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
