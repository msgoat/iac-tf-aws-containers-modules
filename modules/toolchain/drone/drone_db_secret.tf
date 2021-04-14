resource kubernetes_secret drone_db {
  type = "Opaque"
  metadata {
    name = "drone-postgresql"
    namespace = module.namespace.kubernetes_namespace_name
    labels = {
      "app.kubernetes.io/name" = "drone-postgresql"
      "app.kubernetes.io/instance" = "drone-postgresql"
      "app.kubernetes.io/managed-by" = "Terraform"
      "app.kubernetes.io/part-of" = "drone"
    }
  }
  data = {
    postgresql-host = module.postgresql.db_host_name
    postgresql-port = module.postgresql.db_port_number
    postgresql-user = module.postgresql.db_user_name
    postgresql-password = module.postgresql.db_user_password
    DRONE_DATABASE_DATASOURCE = "postgres://${module.postgresql.db_user_name}:${module.postgresql.db_user_password}@${module.postgresql.db_host_name}:${module.postgresql.db_port_number}/drone?sslmode=require"
  }
}