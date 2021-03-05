# ----------------------------------------------------------------------------
# main.tf
# ----------------------------------------------------------------------------

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = var.region_name
}

# Local values used in this module
locals {
  common_tags = {
    Organization = var.organization_name
    Department = var.department_name
    Solution = var.solution_name
    Stage = var.solution_stage
    ManagedBy = "Terraform"
    PartOf = "CloudTrain"
  }
  s3_bucket_name = "s3-${var.region_name}-${var.solution_name}-${var.solution_stage}-terraform"
  dynamodb_table_name = "dyn-${var.region_name}-${var.solution_name}-${var.solution_stage}-terraform"
}

data aws_region current {
  name = var.region_name
}

resource aws_s3_bucket backend {
  bucket = local.s3_bucket_name
  versioning {
    enabled = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  tags = merge({Name = local.s3_bucket_name}, local.common_tags)
}

resource aws_dynamodb_table backend {
  name = local.dynamodb_table_name
  hash_key = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
  billing_mode = "PAY_PER_REQUEST"
  server_side_encryption {
    enabled = true
  }
  tags = merge({Name = local.dynamodb_table_name}, local.common_tags)
}

locals {
  terraform_backend_file = templatefile("${path.module}/resources/terraform_backend.template.tf", {
    tf_s3_bucket_name = local.s3_bucket_name
    tf_dynamodb_table_name = local.dynamodb_table_name
    tf_state_key_name = "${var.solution_name}/${var.solution_stage}/terraform.tfstate"
  })
  terragrunt_remote_state_block = templatefile("${path.module}/resources/terragrunt_remote_state_block.template.hcl", {
    tf_s3_bucket_name = local.s3_bucket_name
    tf_dynamodb_table_name = local.dynamodb_table_name
  })
}