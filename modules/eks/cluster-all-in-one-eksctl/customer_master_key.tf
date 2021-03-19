locals {
  kms_key_name = "cmk-${local.eks_cluster_name}"
}

resource aws_kms_key cmk {
  description = "customer master key for AWS EKS cluster ${local.eks_cluster_name}"
  key_usage = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  deletion_window_in_days = 7
  tags = merge({
    Name = local.kms_key_name
  }, local.module_common_tags)
}

resource aws_kms_alias cmk {
  name = "alias/${local.kms_key_name}"
  target_key_id = aws_kms_key.cmk.id
}
