# Output varaible defenitions

# VPC ID
output "vpc_id" {
  description = "VP"
  value       = aws_vpc.main.id
}
#Subnet ID's
output "subnet_id" {
  description = "ID of subnets"
  value       = aws_subnet.public-subnet.id
}