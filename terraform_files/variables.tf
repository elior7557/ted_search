# Region

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1" # Frankfurt
}


# Network Vars


// Instances vars
# variable "ec2_ami" {
#   type    = string
#   default = "ami-03c476a1ca8e3ebdc" #eu-west-3 ubuntu Paris
# }

# variable "ec2_type" {
#   type    = string
#   default = "t3a.micro"
# }


# variable "associate_public_ip_address" {
#   type    = bool
#   default = true
# }

# variable "key_pair_name" {
#   type    = string
#   default = "Elior-keypair"
# }



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
