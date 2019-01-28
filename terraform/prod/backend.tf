 terraform  {
  backend "gcs"  {
    bucket = "zateevas-tf-state"
    prefix = "hashicorp/rs-prod"
  }
}

