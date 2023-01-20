# Region

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1" # Frankfurt
}


// Common Tags
variable "owner" {
  default = "Elior"
}

variable "bootcamp" {
  default = "17"
}

variable "expiration_date" {
  default = "16-01-23"
}


locals {
  common_tags = {
    Owner           = var.owner
    bootcamp        = var.bootcamp
    expiration_date = var.expiration_date
    created_by      = "terraform"
  }
}
