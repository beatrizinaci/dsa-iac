module "container-security-group" {
    source = "terraform-aws-modules/security-group/aws"
    version = "5.1.0"

    name = "${var.project_name}-${var.environment}-container-security-group"
    description = "Security group for containers"
    vpc_id = module.vpc.vpc_id

    ingress_with_source_security_group_id = [{
        from_port                = var.container_port
        to_port                  = var.container_port
        protocol                 = "tcp"
        source_security_group_id = module.alb-security-group.security_group_id
        description              = "Allow traffic from ALB"
    }]

    egress_rules = ["all-all"]

    tags = {
        Name = "${var.project_name}-${var.environment}-container-security-group"
    }
}

module "alb-security-group" {
    source = "terraform-aws-modules/security-group/aws"
    version = "5.1.0"

    name = "${var.project_name}-${var.environment}-alb-security-group"
    description = "Security group for ALB"
    vpc_id = module.vpc.vpc_id

    ingress_with_cidr_blocks = [{
        from_port = var.alb__sg_port
        to_port = var.alb__sg_port
        protocol = "tcp"
        cidr_blocks = "0.0.0.0/0"
    }]

    egress_rules = ["all-all"]

    tags = {
        Name = "${var.project_name}-${var.environment}-alb-security-group"
    }
}