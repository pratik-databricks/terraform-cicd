
resource "aws_s3_bucket" "root_storage_bucket" {
  bucket = "${var.prefix}-rootbucket"
  acl    = "private"
  versioning {
    enabled = false
  }
  tags = merge(tomap({"Name":"${var.prefix}-rootbucket"}),var.tags)
}
#
terraform {
  required_providers {
    databricks = {
      source  = "databricks/databricks"
    }
  }
}

data "databricks_aws_bucket_policy" "stuff" {
  bucket = aws_s3_bucket.root_storage_bucket.bucket
}

resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.root_storage_bucket.id
  policy = data.databricks_aws_bucket_policy.stuff.json
}