# Output files for compute module

output "key" {
  value = tls_private_key.rsa-key.private_key_pem
}

output "ec2_public_ip" {
  value = aws_instance.myinstance.public_ip
}
output "ec2_id" {
  value = aws_instance.myinstance.id
}


