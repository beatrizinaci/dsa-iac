resource "aws_instance" "dsa_instance" {
    ami           = "ami-0807bd3aff0ae7273"
    instance_type = var.instance_type
    tags = {
        Name = "lab3-t1-tf"
    }

    provisioner "local-exec" {
        command = "echo ${aws_instance.dsa_instance.public_ip} > public_ip.txt"
    }
}