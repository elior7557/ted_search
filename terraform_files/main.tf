

module "network" {
  source      = "./modules/network"
  vpc_name    = "TedSearch-${terraform.workspace}"
  subnet_name = "TedSearch_Public_Subnet-${terraform.workspace}"
  tags        = local.common_tags
}


module "compute" {
  source                = "./modules/compute"
  region                = var.aws_region
  subnet_id             = module.network.subnet_id
  ec2_name              = "TedSearch-${terraform.workspace}"
  sg_name               = "sgTedSearch-${terraform.workspace}"
  vpc_id                = module.network.vpc_id
  key_name              = "TedSearch-${terraform.workspace}_Key"
  tags                  = local.common_tags

}




resource "null_resource" "name" {
  triggers = {
    instance_id = module.compute.ec2_id
  }

  depends_on = [module.compute]

  connection {
    type        = "ssh"
    user        = "ubuntu"
    host        = module.compute.ec2_public_ip
    private_key = module.compute.key
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'hello from the other side'",
    ]
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
    command = "echo ${module.compute.ec2_public_ip} >> ip.txt"
  }


  # #activate the script
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "sudo /tmp/script.sh",
    ]
  }


}
