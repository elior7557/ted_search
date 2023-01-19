# Output varaible defenitions

# Networking

# VPC_ID
output "vpc_id" {
  value = module.network.vpc_id
}

# Subnet_ID
output "subnet_id" {
  value = module.network.subnet_id
}

# Ec2 Public_IP
output "public_ip" {
  value = module.compute.ec2_public_ip
}