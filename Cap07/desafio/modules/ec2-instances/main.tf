data "aws_subnet" "selected" {
    id = var.subnets[0]
}

resource "aws_security_group" "http_sg" {
    name        = "dsa-http-sg"
    description = "Allow HTTP"
    vpc_id      = data.aws_subnet.selected.vpc_id

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }
}

resource "aws_instance" "dsa_instance" {
    count         = var.ami_id == var.required_ami_id ? var.instance_count : 0
    ami           = var.ami_id
    instance_type = var.instance_type
    subnet_id     = var.subnets[0]

    vpc_security_group_ids = [aws_security_group.http_sg.id]

    user_data = <<-EOF
                #!/bin/bash
                yum update -y
                yum install -y httpd
                systemctl enable httpd
                systemctl start httpd
                echo "<h1>Bem-vindo ao Server ${count.index + 1}</h1>" > /var/www/html/index.html
                EOF

    tags = {
        Name = "dsa-server-${count.index + 1}"
    }
}