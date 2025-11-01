module "vpc" {
    source = "terraform-aws-modules/vpc/aws"
    version = "5.4.0"

    name = "ecs-vpc"
    cidr = var.vpc_cidr_block
    
    azs = [var.availability_zones_1, var.availability_zones_2]
    private_subnets = [var.private_subnet_1_cdir_block]
    public_subnets = [var.public_subnet_1_cdir_block, var.public_subnet_2_cdir_block]

    private_subnet_tags = {
        Name = "${var.project_name}-${var.environment}-private-subnet"
    }

    public_subnet_tags = {
        Name = "${var.project_name}-${var.environment}-public-subnet"
    }

    igw_tags = {
        Name = "${var.project_name}-${var.environment}-igw"
    }

    default_security_group_tags = {
        Name = "${var.project_name}-${var.environment}-default-security-group"
    }

    default_route_table_tags = {
        Name = "${var.project_name}-${var.environment}-main-route-table"
    }

    public_route_table_tags = {
        Name = "${var.project_name}-${var.environment}-public-route-table"
    }

    tags = {
        Name = "${var.project_name}-${var.environment}-vpc"
    }
}

