variable "region" {
    description = "AWS Region"
    type = string
    default = "us-east-2"
}

variable "ami_id" {
    description = "AMI (Amazon machine image) ID"    
    type = string
}

variable "instance_type" {
    description = "EC2 Instance Type"
    type = string
    default = "t2.micro"
}

variable "vpc_ids" {
    description = "VPC IDs"
    type = list(string)
}

variable "subnets" {
    description = "Subnet IDs"
    type = list(string)
}
