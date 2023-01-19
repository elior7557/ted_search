resource "aws_instance" "myinstance" {
  ami                         = var.ec2_ami
  instance_type               = var.ec2_type
  vpc_security_group_ids      = [aws_security_group.httpSSH.id]
  subnet_id                   = "subnet-0f2f68a6e4ba9e705"
  associate_public_ip_address = var.associate_public_ip_address
  key_name                    = aws_key_pair.aws_key_pair.key_name  

  tags = merge(local.common_tags, {
    Name = "TedSearch-${terraform.workspace}"
  })
}



resource "null_resource" "name" {
  triggers = {
    instance_id = aws_instance.myinstance.id
  }

  depends_on = [aws_instance.myinstance]

  connection {
    type        = "ssh"
    user        = "ubuntu"
    host        = aws_instance.myinstance.public_ip
    private_key = tls_private_key.rsa-key.private_key_pem
  }

  # script
  provisioner "file" {
    source      = "deployment.sh"
    destination = "/tmp/script.sh"
  }
  # deployment folder
  provisioner "file" {
    source      = "./production"
    destination = "/tmp"
  }


  provisioner "local-exec" {
    command = "echo ${aws_instance.myinstance.public_ip} >> ip.txt"
  }


  #activate the script
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "sudo /tmp/script.sh",
    ]
  }

}


# Create a private and public key
resource "tls_private_key" "rsa-key" {
  algorithm = "RSA"
}

resource "aws_key_pair" "aws_key_pair" {
  key_name   = "terraform-key-elior"
  public_key = tls_private_key.rsa-key.public_key_openssh
}







output "public_ip" {
  value = aws_instance.myinstance.*.public_ip
}

// Seurity Groups
resource "aws_security_group" "httpSSH" {
  name        = "ted-search_sg"
  description = "ssh,http"
  vpc_id      = "vpc-009ab8fc713ac0617"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.common_tags
}

