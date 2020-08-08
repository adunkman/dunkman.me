resource "aws_s3_bucket" "dunkman_me" {
  bucket = "dunkman.me"
  acl = "private"
}

resource "aws_s3_bucket_public_access_block" "dunkman_me" {
  bucket = aws_s3_bucket.dunkman_me.id

  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}
