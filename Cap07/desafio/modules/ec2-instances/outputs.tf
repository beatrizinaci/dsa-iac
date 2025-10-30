output "instance_ids" {
    value = aws_instance.dsa_instance.*.id
}

output "public_ips" {
    value = aws_instance.dsa_instance.*.public_ip
}