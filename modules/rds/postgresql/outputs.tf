output db_instance_id {
  description = "Unique identifier of the DB instance"
  value = aws_db_instance.postgresql.arn
}

output db_host_name {
  description = "Host name of the DB endpoint"
  value = aws_db_instance.postgresql.endpoint
}

output db_host_ip {
  description = "IP address of the DB endpoint"
  value = aws_db_instance.postgresql.address
}

output db_port_number {
  description = "Port number of the DB endpoint"
  value = aws_db_instance.postgresql.port
}

output db_user_name {
  description = "Name of the DB master user"
  value = aws_db_instance.postgresql.username
}

output db_user_password {
  description = "Password of the DB master user"
  value = aws_db_instance.postgresql.password
}