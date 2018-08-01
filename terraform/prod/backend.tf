terraform {
  backend "gcs" {
    bucket = "storage-bucket-akha"
    prefix = "terraform/state/prod"
  }
}
