output drone_admin_user_name {
  description = "Name of the Drone admin user"
  value = random_string.drone_admin_user.result
}

output drone_admin_user_password {
  description = "Password of the Drone admin user"
  value = random_password.drone_admin_password.result
}

output drone_db_instance_id {
  description = "Unique identifier of the Drone database"
  value = module.postgresql.db_instance_id
}

output drone_db_host_name {
  description = "Host name of the Drone database"
  value = module.postgresql.db_host_name
}

output drone_db_port_number {
  description = "Port number of the Drone database"
  value = module.postgresql.db_port_number
}