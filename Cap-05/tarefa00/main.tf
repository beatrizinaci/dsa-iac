variable "region" {
    description = "Região do AWS"
    default = "us-east-2"
}

variable "ami" {
    description = "AMI (Amazon machine image) do EC2"    
}

variable "instance_type" {
    description = "Tipo de instância do EC2"
}

provider "aws" {
    region = var.region
}

resource "aws_instance" "ec2_instance" {
    ami = var.ami
    instance_type = var.instance_type
    tags = {
        Name = "tarefa 1 terraform"
    }
}