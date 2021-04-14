# iam_user.tf
# ---------------------------------------------------------------------------
# creates an IAM user with permissions to access the Drone S3 storage backend
# ---------------------------------------------------------------------------

locals {
  iam_user_name = "drone-${var.region_name}-${var.solution_fqn}"
}

resource aws_iam_user drone {
  name = local.iam_user_name
  force_destroy = true
  tags = merge({ Name = local.iam_user_name }, local.module_common_tags)
}

resource aws_iam_access_key drone {
  user = aws_iam_user.drone.name
}

resource aws_iam_user_policy drone_s3_full_access {
  name = "policy-${var.region_name}-${var.solution_fqn}-drone"
  user = aws_iam_user.drone.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action: [
          "s3:DeleteBucket",
          "s3:CreateBucket"
        ],
        Effect   = "Allow"
        Resource = [aws_s3_bucket.backend.arn]
      },
    ]
  })
}