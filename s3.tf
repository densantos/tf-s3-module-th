data "aws_caller_identity" "current" {}

locals {
  # Format region code into 3 chars | Ex. us-east-1 = ue1
  region_substring = "${substr(var.region, 0, 1)}${substr(var.region, 3, 1)}${substr(var.region, -1, 1)}"
  # If bucket_name is not declared in the deployment, generates a standard bucket name
  bucket_name      = lower(coalesce(var.bucket_name, "s3-${var.application_id}-${var.environment}-${local.region_substring}"))
  # Determine policy principal
  policy_identifier = !var.block_public_access ? ["*"] : length(var.bucket_access_roles) == 0 ? ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"] : var.bucket_access_roles
  
  common_tags = {
    Name          = local.bucket_name
    ApplicationID = var.application_id
    Environment   = var.environment
  }
}

resource "aws_s3_bucket" "bucket" {
  bucket = local.bucket_name
  tags = merge(
    local.common_tags
  )
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = var.block_public_access
  block_public_policy     = var.block_public_access
  ignore_public_acls      = var.block_public_access
  restrict_public_buckets = var.block_public_access
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.bucket.id
  policy = data.aws_iam_policy_document.policy.json
  depends_on = [ aws_s3_bucket_public_access_block.public_access ]
}