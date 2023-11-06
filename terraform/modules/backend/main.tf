data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

locals {
  uuid = uuidv5("oid", data.aws_caller_identity.current.account_id)
}

#tfsec:ignore:aws-dynamodb-enable-at-rest-encryption tfsec:ignore:aws-dynamodb-enable-recovery tfsec:ignore:aws-dynamodb-table-customer-key
resource "aws_dynamodb_table" "terraform_lock" {
  name           = "${var.table_name}"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name    = "dydb-${var.basename}"
    Details = "${data.aws_region.current.name}:tf"
  }
}

#tfsec:ignore:aws-s3-enable-bucket-logging tfsec:ignore:aws-s3-enable-bucket-encryption tfsec:ignore:aws-s3-encryption-customer-key
resource "aws_s3_bucket" "terraform_state" {
  bucket = "${var.bucket_name}"
  # force destroy will allow deletion even if items remain in the bucket 
  force_destroy = true
  tags = {
    Name    = "s3-${var.basename}-tf-state-backend"
    Details = "${data.aws_region.current.name}:tf"
  }
}

resource "aws_s3_bucket_public_access_block" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}

resource "aws_s3_bucket_ownership_controls" "s3_bucket_acl_ownership" {
  bucket = aws_s3_bucket.terraform_state.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Make sure that we only ever store encrypted state stuff here
# http://docs.aws.amazon.com/AmazonS3/latest/dev/UsingServerSideEncryption.html

resource "aws_s3_bucket_policy" "terraform_state_policy" {
  bucket = aws_s3_bucket.terraform_state.id

  policy = <<EOF
{
  "Id": "PutObjPolicy",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:ListBucket",
      "Resource": "arn:aws:s3:::${aws_s3_bucket.terraform_state.id}",
      "Condition": {
          "StringEquals": {
              "aws:PrincipalOrgID": "o-vzc1tsnwbz"
          }
      }
    },
    {
        "Effect": "Deny",
        "Principal": "*",
        "Action": "s3:PutObject",
        "Resource": "arn:aws:s3:::${aws_s3_bucket.terraform_state.id}/*",
        "Condition": {
            "StringNotEquals": {
                "s3:x-amz-server-side-encryption": "AES256"
            }
        }
    },
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": [
          "s3:GetObject",
          "s3:PutObject"
      ],
      "Resource": "arn:aws:s3:::${aws_s3_bucket.terraform_state.id}/*",
      "Condition": {
          "StringEquals": {
            "aws:PrincipalOrgID": "o-vzc1tsnwbz"
          }
      }
    }
  ]
}
EOF
}
