# Create a new ec2 attached with eip and security group
terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "4.56.0"
    }
    random = {
        source = "hashicorp/random"
        version = "3.0.0"
    }
  }
}
provider "aws" {
  region = var.aws_region 
}
provider "random" {
  #configuration_options   
}
locals {
  instance_type = var.instance_type
}
resource "aws_instance" "this_ec2" {
  ami           = var.ami_id
  instance_type = local.instance_type
}

resource "aws_eip" "this_eip" {
  vpc      = true
}

resource "aws_eip_association" "this_eip_assoc" {
  instance_id = aws_instance.this_ec2.id
  allocation_id = aws_eip.this_eip.id
}
output "public_dns_name" {
  value = aws_instance.this_ec2.public_dns
}
output "private_dns_name" {
  value = aws_instance.this_ec2.private_dns
}
output "private_ip" {
  value = aws_instance.this_ec2.private_ip
}