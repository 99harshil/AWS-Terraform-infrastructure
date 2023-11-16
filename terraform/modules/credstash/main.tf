resource "aws_kms_key" "credstash-key" {
  count               = var.create_kms_key ? 1 : 0
  description         = "Master key used by credstash"
  enable_key_rotation = var.enable_key_rotation

  tags = {
    Name = "${var.kms_key_name}-kms-key"
  }
}

resource "aws_kms_alias" "credstash-key" {
  count         = var.create_kms_key ? 1 : 0
  name          = "alias/${var.kms_key_name}-kms-key"
  target_key_id = aws_kms_key.credstash-key[0].key_id
}

resource "aws_dynamodb_table" "credstash-db" {
  count          = var.create_kms_key ? 1 : 0
  name           = "${var.kms_key_name}-credstash-table"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "name"
  range_key      = "version"

  attribute {
    name = "name"
    type = "S"
  }

  attribute {
    name = "version"
    type = "S"
  }
}

## Writer Policy

resource "aws_iam_policy" "writer-policy" {
  count  = var.create_writer_policy ? 1 : 0
  name   = "${var.kms_key_name}-writer"
  policy = data.aws_iam_policy_document.writer-policy.json
}

## Reader Policy

resource "aws_iam_policy" "reader-policy" {
  count  = var.create_reader_policy ? 1 : 0
  name   = "${var.kms_key_name}-reader"
  policy = data.aws_iam_policy_document.reader-policy.json
}
