# resource "helm_release" "wordpress" {
#   name       = "wp"
#   repository = "https://charts.bitnami.com/bitnami"
#   chart      = "wordpress"
#   version    = "15.2.36"

#   values = [
#     "${file("helm/wordpress/values.yaml")}"
#   ]

#   set {
#     name  = "externalDatabase.host"
#     value = "127.0.0.1"
#   }

#   set {
#     name  = "externalDatabase.password"
#     value = module.database.generated_user_password
#   }

#   set {
#     name  = "serviceAccount.name"
#     value = "wordpress-gke"
#   }

#   set {
#     name  = "sidecars[0].name"
#     value = "cloud-sql-proxy"
#   }

#   set {
#     name  = "sidecars[0].image"
#     value = "gcr.io/cloudsql-docker/gce-proxy:latest"
#   }

#   set {
#     name  = "sidecars[0].command[0]"
#     value = "/cloud_sql_proxy"
#   }

#   set {
#     name  = "sidecars[0].command[1]"
#     value = "-ip_address_types=PRIVATE"
#   }

#   set {
#     name  = "sidecars[0].command[2]"
#     value = "-instances=${module.database.instance_connection_name}=tcp:3306"
#   }

#   set {
#     name  = "sidecars[0].securityContext"
#     value = "runAsNonRoot: true"
#   }

# }
