# Variable of the compute module


### Optinal ###
variable "create_before_destroy" {
  type    = bool
  default = false
}



### Required  ###
variable "tags" {
  type = map(any)
}

variable "region" {
  type = string
  validation {
    condition     = (var.region == "eu-central-1" || var.region == "eu-west-2" || var.region == "eu-west-3")
    error_message = "Region Is Not Allowed"
  }
}

variable "vpc_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "ec2_name" {
  type = string
}


variable "key_name" {
  type = string
}

### Optinal ###
variable "http_port" {
  type    = number
  default = 80
}

variable "sg_name" {
  type    = string
  default = "mysg"
}


