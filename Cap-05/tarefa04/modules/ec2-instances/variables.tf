variable "instance_count" {
    description = "Number of instances"
    type = number    
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


variable "subnets" {
    description = "Subnet IDs"
    type = list(string)
}
