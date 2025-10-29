provider "aws" {
  region = var.region
}

resource "aws_instance" "ec2_instance" {
  ami           = var.ami
  instance_type = var.instance_type
  tags = {
    Name = "tarefa 3 terraform"
  }
}

