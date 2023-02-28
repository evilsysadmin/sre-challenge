# resource "google_service_account" "sa" {
#   account_id   = "${var.project_id}-id"
#   display_name = "${var.project_id} Service Account"
# }

# resource "google_storage_bucket_iam_member" "this" {
#   bucket = google_storage_bucket.bucket.name
#   role   = "roles/storage.admin"
#   member = "serviceAccount:${google_service_account.sa.email}"
# }

# resource "google_project_iam_member" "iam_user_cloudsql_client" {
#   role    = "roles/cloudsql.client"
#   project = var.project_id
#   member  = "serviceAccount:${google_service_account.sa.email}"
# }

module "workload-identity" {
  source     = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
  name       = var.app_name
  namespace  = "default"
  project_id = var.project_id
  roles      = ["roles/storage.admin", "roles/cloudsql.client"]
}
