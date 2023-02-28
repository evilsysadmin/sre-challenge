module "database" {
  source               = "git::https://github.com/terraform-google-modules/terraform-google-sql-db.git//modules/safer_mysql"
  name                 = var.db_name
  random_instance_name = false
  database_version     = "MYSQL_5_6"
  db_name              = "bitnami_wordpress"
  project_id           = var.project_id
  zone                 = "us-west1-c"
  region               = "us-west1"
  tier                 = "db-f1-micro"
  create_timeout       = "60m"
  vpc_network          = module.gcp-network.network_self_link

  deletion_protection = false

  database_flags = [
    {
      name  = "log_bin_trust_function_creators"
      value = "on"
    },
  ]

  depends_on = [module.private-service-access]
}

resource "kubernetes_secret" "db-secret" {
  metadata {
    name = "db-secret"
  }

  data = {
    mysql = module.database.generated_user_password
  }
}
