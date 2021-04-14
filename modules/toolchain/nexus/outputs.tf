output s3_access_key_id {
  description = "Unique identifier of the API access key used by nexus to access the S3 storage backend"
  value = aws_iam_access_key.nexus.id
}

output s3_access_key_secret {
  description = "Secret of the API access key used by nexus to access the S3 storage backend"
  value = aws_iam_access_key.nexus.secret
}