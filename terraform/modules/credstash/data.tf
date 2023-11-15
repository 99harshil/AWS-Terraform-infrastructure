data "aws_caller_identity" "current" {
}

data "aws_region" "current" {
}

data "aws_partition" "current" {
}

# Writer Policy
data "aws_iam_policy_document" "writer-policy" {
  statement {
    effect = "Allow"
    actions = ["dynamodb:PutItem"]

    resources = [
      "arn:${data.aws_partition.current.partition}:dynamodb:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:table/${var.kms_key_name}-credstash-table",
    ]
  }
}

# Reader Policy
data "aws_iam_policy_document" "reader-policy" {
  statement {
    effect = "Allow"

    actions = [
      "dynamodb:GetItem",
      "dynamodb:Query",
      "dynamodb:Scan",
    ]

    resources = [
      "arn:${data.aws_partition.current.partition}:dynamodb:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:table/${var.kms_key_name}-credstash-table",
    ]
  }
}
