provider "google" {
  version = "1.4.0"
  project = "${var.project}"
  region  = "${var.region}"
}

module "app" {
  source          = "../modules/app"
  public_key_path = "${var.public_key_path}"
  app_region      = "${var.app_region}"
  app_disk_image  = "${var.app_disk_image}"
}

module "db" {
  source          = "../modules/db"
  public_key_path = "${var.public_key_path}"
  app_region      = "${var.app_region}"
  db_disk_image   = "${var.db_disk_image}"
}

module "vpc" {
  source        = "../modules/vpc"
  source_ranges = ["85.141.75.207/32"]
}
