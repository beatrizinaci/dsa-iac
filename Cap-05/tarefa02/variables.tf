variable "region" {
  description = "Região do AWS"
  default     = "us-east-2"
}

variable "ami" {
  description = "AMI (Amazon machine image) do EC2"
}

variable "instance_type" {
  description = "Tipo de instância do EC2"
}

