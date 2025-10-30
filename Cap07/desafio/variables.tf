variable "region" {
    description = "AWS region"
    type        = string
    default     = "us-east-1"
}

variable "instance_count" {
    description = "Number of instances to create"
    type        = number
    default     = 3
}

variable "ami_id" {
    description = "AMI ID used for the instances"
    type        = string
}

variable "required_ami_id" {
    description = "Only create instances if ami_id equals this value"
    type        = string
}

variable "instance_type" {
    description = "EC2 instance type"
    type        = string
    default     = "t2.micro"
}

variable "subnets" {
    description = "Subnet IDs to place the instances"
    type        = list(string)
}

