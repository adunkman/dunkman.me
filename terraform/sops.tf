# aws-kms-auto-rotate-keys - rotation of keys would prevent accessing encryped files
#
# tfsec:ignore:aws-kms-auto-rotate-keys
resource "aws_kms_key" "sops" {
  description = "Key used for SOPS"
}

output "sops_kms_arn" {
  value = aws_kms_key.sops.arn
}
