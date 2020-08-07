resource "aws_s3_bucket" "dunkman_me" {
  bucket = "dunkman.me"
  acl = "private"
}
