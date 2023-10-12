# ReadOnly S3 Access Policy
data "aws_iam_policy_document" "policy" {
  statement {
    sid    = "AllowReadOnlyAccess"
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:ListBucket"
    ]

    resources = [
      "${aws_s3_bucket.bucket.arn}",
      "${aws_s3_bucket.bucket.arn}/*",
    ]

    principals {
      type        = "AWS"
      identifiers = local.policy_identifier
    }
  }
}





