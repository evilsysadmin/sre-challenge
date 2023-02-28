terraform {
  backend "gcs" {
    bucket = "myproject-012345-tf-remote-state"
    prefix = "state"
  }
}
