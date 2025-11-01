variable "project_name" {
    description = "Project name"
    type = string
}

variable "environment" {
    description = "Environment"
    type = string
}

variable "cpu" {
    description = "CPU"
    type = number
}

variable "memory" {
    description = "Memory"
    type = number
}

variable "docker_image_name" {
    description = "Docker image name"
    type = string
}

variable "container_port" {
    description = "Container port"
    type = number
}

variable "s3_env_vars_file_arn" {
    description = "S3 environment variables file ARN"
    type = string
}

variable "region" {
    description = "AWS region"
    type = string
}

variable "health_check_path" {
    description = "Health check path"
    type = string
    default = "/"
}

variable "vpc_cidr_block" {
    description = "VPC CIDR block"
    type = string
}

variable "availability_zones_1" {
    description = "Availability zone 1"
    type = string
}

variable "availability_zones_2" {
    description = "Availability zone 2"
    type = string
}

variable "private_subnet_1_cdir_block" {
    description = "Private subnet 1 CIDR block"
    type = string
}

variable "public_subnet_1_cdir_block" {
    description = "Public subnet 1 CIDR block"
    type = string
}

variable "public_subnet_2_cdir_block" {   
    description = "Public subnet 2 CIDR block"
    type = string
}

variable "alb__sg_port" {
    description = "ALB security group port"
    type = number
}