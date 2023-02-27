# Create a new ec2 attached with eip and security group
terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "4.56.0"
    }
  }
}

provider "aws" {
  #configuration_options   
}

resource "aws_instance" "blackocean_ec2" {
  ami           = "ami-0e742cca61fb65051"
  instance_type = "t2.micro"
}

resource "aws_eip" "lb" {
  vpc      = true
}

resource "aws_eip_association" "aws_eip_assoc" {
  instance_id = aws_instance.blackocean_ec2.id
  allocation_id = aws_eip.lb.id
}

resource "aws_security_group" "allow_tls" {
  name        = "BlackOcean_VPC"
  vpc_id      = "vpc-0c3e07a79d629365c"

  ingress {

    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["${aws_eip.lb.public_ip}/32"]
  }
}