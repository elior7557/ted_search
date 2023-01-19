# Variables For The Network Module

### Required  ###
variable "tags" {
  type = map(any)
}

# VPC Name
variable "vpc_name" {
  type = string
}


### Optional ###

# VPC Cidr
variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "subnet_cidr" {
  type    = string
  default = "10.0.0.0/24"
}

variable "subnet_name" {
  type    = string
  default = "public_subent"
}



