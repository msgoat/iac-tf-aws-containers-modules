locals {
  db_instance_name = "postgres-${var.region_name}-${var.solution_fqn}-${var.db_instance_name}"
}

resource aws_db_instance postgresql {
  identifier = local.db_instance_name
  name = var.db_database_name
  engine = "postgres"
  engine_version = var.postgresql_version
  allow_major_version_upgrade = false
  auto_minor_version_upgrade = true
  instance_class = var.db_instance_class
  storage_type = "gp2"
  allocated_storage = var.db_min_storage_size
  max_allocated_storage = var.db_max_storage_size
  storage_encrypted = true
  backup_retention_period = 7
  # backup_window = "22:00-23:59"
  delete_automated_backups = true
  skip_final_snapshot = true
  # maintenance_window = "00:00-06:00"
  copy_tags_to_snapshot = true
  username = random_string.db_user.result
  password = random_password.db_password.result
  iam_database_authentication_enabled = true
  db_subnet_group_name = aws_db_subnet_group.postgresql.name
  vpc_security_group_ids = [aws_security_group.postgresql.id]
  tags = merge({
    Name = local.db_instance_name
  }, local.module_common_tags)
}