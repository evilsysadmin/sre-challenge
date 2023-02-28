
resource "google_storage_bucket" "this" {
  name          = var.bucket_name
  force_destroy = true
  location      = "US"
  storage_class = "STANDARD"
  versioning {
    enabled = false
  }
}
