variable project {
  description = "Project ID"
}

variable region {
  description = "Region"
  default     = "europe-west1"
}

variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable disk_image {
  description = "Disk image"
}

variable priv_key {
  description = "Private key"
}

variable app_region {
  description = "app zone"
  default     = "europe-west1-b"
}
