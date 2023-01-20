# Compute file 
# This file contains:
//ec2
//sg

locals {
  ami_map = {
    eu-central-1 = "ami-03e08697c325f02ab"
    eu-west-2    = "ami-084e8c05825742534"
    eu-west-3    = "ami-0afd55c0c8a52973a"
  }
}



resource "aws_instance" "myinstance" {
  ami                         = local.ami_map[var.region]
  instance_type               = "t3a.micro"
  vpc_security_group_ids      = [aws_security_group.my-sg.id]
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true
  key_name                    = aws_key_pair.aws_key_pair.key_name

  lifecycle {
    create_before_destroy = true
  }


  tags = merge(var.tags, {
    Name = var.ec2_name
  })
}


// Keys
# Create a private and public key
resource "tls_private_key" "rsa-key" {
  algorithm = "RSA"
}

resource "aws_key_pair" "aws_key_pair" {
  key_name   = "terraform-key-elior-tf"
  public_key = tls_private_key.rsa-key.public_key_openssh
}




// Seurity Groups
resource "aws_security_group" "my-sg" {
  name        = var.sg_name
  description = "HTTP and SSH"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}