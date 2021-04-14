resource kubernetes_secret drone_s3 {
  type = "Opaque"
  metadata {
    name = "drone-s3"
    namespace = module.namespace.kubernetes_namespace_name
    labels = {
      "app.kubernetes.io/name" = "drone-s3"
      "app.kubernetes.io/instance" = "drone-s3"
      "app.kubernetes.io/managed-by" = "Terraform"
      "app.kubernetes.io/part-of" = "drone"
    }
  }
  data = {
    AWS_ACCESS_KEY_ID = aws_iam_access_key.drone.id
    AWS_SECRET_ACCESS_KEY = aws_iam_access_key.drone.secret
    AWS_DEFAULT_REGION = var.region_name
    AWS_REGION = var.region_name
    DRONE_S3_BUCKET = aws_s3_bucket.backend.bucket
  }
}