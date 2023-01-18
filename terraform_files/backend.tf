terraform {
  backend "s3" {
    bucket = "elior-tf-state"
    key    = "dynamic-way/terraform.tfstate"
    region = "eu-west-3"
  }
}
