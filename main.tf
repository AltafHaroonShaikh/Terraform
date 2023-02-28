# Create one IAM user and one IAM Group using Terraform
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
  #configuration_options   
}

provider "random" {
  #configuration_options   
}

resource "aws_iam_user" "user" {
  name = var.iam_user_name
}

resource "aws_iam_group" "group" {
  name = var.iam_group_name
}

resource "aws_iam_group_membership" "group_membership" {
  name = var.iam_group_membership
  users = [aws_iam_user.user.name]
  group = aws_iam_group.group.name 
}