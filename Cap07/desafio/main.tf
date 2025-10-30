module "dsa_ec2_instances" {
    source = "./modules/ec2-instances"

    instance_count   = var.instance_count
    ami_id           = var.ami_id
    required_ami_id  = var.required_ami_id
    instance_type    = var.instance_type
    subnets          = var.subnets
}