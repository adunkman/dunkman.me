variable "friends_and_family_passcode" {
  sensitive = true
}

data "local_file" "authenticator" {
  filename = "./auth.js"
}

data "template_file" "config" {
  template = file("./auth.config.json.tpl")
  vars = {
    friends_and_family_passcode = var.friends_and_family_passcode
  }
}

data "archive_file" "authenticator" {
  type = "zip"
  output_path = "/terraform/authenticator.zip"

  source {
    content = data.local_file.authenticator.content
    filename = "auth.js"
  }

  source {
    content = data.template_file.config.rendered
    filename = "auth.config.json"
  }
}

locals {
  function_name = "authenticator"
}

resource "aws_lambda_function" "authenticator" {
  function_name = local.function_name
  filename = data.archive_file.authenticator.output_path
  source_code_hash = data.archive_file.authenticator.output_base64sha256
  role = aws_iam_role.authenticator.arn
  handler = "auth.handler"
  runtime = "nodejs24.x"
  publish = true

  tracing_config {
     mode = "Active"
   }

  depends_on = [
    aws_cloudwatch_log_group.authenticator
  ]
}

# aws-cloudwatch-log-group-customer-key - no need to encrypt this
#
# tfsec:ignore:aws-cloudwatch-log-group-customer-key
resource "aws_cloudwatch_log_group" "authenticator" {
  name = "/aws/lambda/us-east-1.${local.function_name}"
  retention_in_days = 14
}

resource "aws_iam_role" "authenticator" {
  name = "authenticator"
  assume_role_policy = data.aws_iam_policy_document.authenticator.json
}

resource "aws_iam_policy_attachment" "authenticator_policy" {
  name = "authenticator_policy"
  roles = [ aws_iam_role.authenticator.name ]
  policy_arn = aws_iam_policy.authenticator_policy.arn
}

resource "aws_iam_policy" "authenticator_policy" {
  name = "authenticator_policy"
  policy = data.aws_iam_policy_document.authenticator_policy.json
}

data "aws_iam_policy_document" "authenticator" {
  statement {
    actions = [ "sts:AssumeRole" ]

    principals {
      type = "Service"
      identifiers = [
        "lambda.amazonaws.com",
        "edgelambda.amazonaws.com",
      ]
    }
  }
}

# aws-iam-no-policy-wildcards - this is already restricted to the group created
#
# tfsec:ignore:aws-iam-no-policy-wildcards
data "aws_iam_policy_document" "authenticator_policy" {
  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = [
      "${aws_cloudwatch_log_group.authenticator.arn}:*"
    ]
  }
}
