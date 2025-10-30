output "instance_ids" {
    value = module.dsa_ec2_instances.instance_ids
}

output "public_ips" {
    value = module.dsa_ec2_instances.public_ips
}