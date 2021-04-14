locals {
  s3_bucket_name = "s3-${var.region_name}-${var.solution_fqn}-nexus"
}

resource aws_s3_bucket storage_backend {
  bucket = local.s3_bucket_name
  versioning {
    enabled = false
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  tags = merge({Name = local.s3_bucket_name}, local.module_common_tags)
}

resource aws_s3_bucket_policy storage_backend_access {
  bucket = aws_s3_bucket.storage_backend.id
  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Id": "NexusS3BlobStorePolicy",
    "Statement": [
        {
            "Sid": "NexusS3BlobStoreAccess",
            "Effect": "Allow",
            "Principal": {
                "AWS": "${aws_iam_user.nexus.arn}"
            },
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:DeleteObject",
                "s3:ListBucket",
                "s3:GetLifecycleConfiguration",
                "s3:PutLifecycleConfiguration",
                "s3:PutObjectTagging",
                "s3:GetObjectTagging",
                "s3:DeleteObjectTagging",
                "s3:GetBucketAcl"
            ],
            "Resource": [
                "${aws_s3_bucket.storage_backend.arn}",
                "${aws_s3_bucket.storage_backend.arn}/*"
            ]
        }
    ]
}
POLICY
}

resource aws_s3_bucket_public_access_block storage_backend {
  bucket = aws_s3_bucket.storage_backend.id
  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}