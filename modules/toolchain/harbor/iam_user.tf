# iam_user.tf
# ---------------------------------------------------------------------------
# creates an IAM user with permissions to access the Harbor S3 storage backend
# ---------------------------------------------------------------------------

locals {
  iam_user_name = "harbor-${var.region_name}-${var.solution_fqn}"
}

resource aws_iam_user harbor {
  name = local.iam_user_name
  force_destroy = true
  tags = merge({ Name = local.iam_user_name }, local.module_common_tags)
}

resource aws_iam_access_key harbor {
  user = aws_iam_user.harbor.name
}

resource aws_iam_user_policy harbor_s3_full_access {
  name = "policy-${var.region_name}-${var.solution_fqn}-harbor"
  user = aws_iam_user.harbor.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action: [
          "s3:GetLifecycleConfiguration",
          "s3:GetBucketTagging",
          "s3:GetInventoryConfiguration",
          "s3:GetObjectVersionTagging",
          "s3:ListBucketVersions",
          "s3:GetBucketLogging",
          "s3:ListBucket",
          "s3:GetAccelerateConfiguration",
          "s3:GetBucketPolicy",
          "s3:GetObjectVersionTorrent",
          "s3:GetObjectAcl",
          "s3:GetEncryptionConfiguration",
          "s3:GetBucketObjectLockConfiguration",
          "s3:GetBucketRequestPayment",
          "s3:GetObjectVersionAcl",
          "s3:GetObjectTagging",
          "s3:GetMetricsConfiguration",
          "s3:GetBucketOwnershipControls",
          "s3:GetBucketPublicAccessBlock",
          "s3:GetBucketPolicyStatus",
          "s3:GetObjectRetention",
          "s3:GetBucketWebsite",
          "s3:GetBucketVersioning",
          "s3:GetBucketAcl",
          "s3:GetBucketNotification",
          "s3:GetReplicationConfiguration",
          "s3:GetObject",
          "s3:GetObjectTorrent",
          "s3:GetBucketCORS",
          "s3:GetObjectVersionForReplication",
          "s3:GetBucketLocation",
          "s3:GetObjectVersion"
        ],
        Effect   = "Allow"
        Resource = ["arn:aws:s3:::*/*", aws_s3_bucket.backend.arn]
      },
    ]
  })
}