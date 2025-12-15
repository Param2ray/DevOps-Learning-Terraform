terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.25.0"
    }
  }
}

provider "aws" {
    region = "ca-central-1"
}

resource "aws_instance" "wordpress1" {
  ami                     = local.instance_ami
  instance_type           = var.instance_type
  vpc_security_group_ids = [aws_security_group.wordpress1.id]
  user_data = file("install_wordpress.sh")
  
}

resource "aws_security_group" "wordpress1" {
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}