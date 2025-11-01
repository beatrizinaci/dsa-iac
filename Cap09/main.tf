resource "aws_ecs_cluster" "dsa_cluster" {
    name = "${var.project_name}-${var.environment}-cluster"
}

resource "aws_cloudwatch_log_group" "dsa_log_group" {
    name = "${var.project_name}-${var.environment}-log-group"
}

resource "aws_ecs_task_definition" "dsa_task" {
    family                   = "${var.project_name}-${var.environment}-task-definition"
    network_mode             = "awsvpc"
    requires_compatibilities = ["FARGATE"]
    cpu                      = var.cpu
    memory                   = var.memory
    execution_role_arn       = "arn:aws:iam::390403879071:role/ecsTaskExecutionRole"
    task_role_arn            = "arn:aws:iam::390403879071:role/ecsTaskExecutionRole"
    tags = {
        Name = "${var.project_name}-${var.environment}-task-definition"
    }

    container_definitions = jsonencode([
        {
            name = "${var.project_name}-${var.environment}-container"
            image = var.docker_image_name
            essential = true
            portMappings = [
                {
                    containerPort = var.container_port
                    hostPort = var.container_port
                    protocol = "tcp"
                    appProtocol = "http"
                }
            ]

            environmentFiles = [
                {
                    type = "s3",
                    value = var.s3_env_vars_file_arn
                }
            ]
            logConfiguration = {
                logDriver = "awslogs"
                options = {
                    "awslogs-create-group" = "true"
                    awslogs-group = aws_cloudwatch_log_group.dsa_log_group.name
                    awslogs-region = var.region
                    awslogs-stream-prefix = "ecs"
                }
            }
        }
    ])
}

resource "aws_ecs_service" "dsa_service" {
    name = "${var.project_name}-service"
    cluster = aws_ecs_cluster.dsa_cluster.id
    task_definition = aws_ecs_task_definition.dsa_task.arn
    desired_count = 1
    launch_type = "FARGATE"

    network_configuration {
        assign_public_ip = true
        subnets          = [module.vpc.public_subnets[0]]                      
        security_groups  = [module.container-security-group.security_group_id] 
    }

    health_check_grace_period_seconds = 60

    load_balancer {
        target_group_arn = aws_lb_target_group.dsa_target_group.arn
        container_name = "${var.project_name}-${var.environment}-container"
        container_port = var.container_port
    }
}

resource "aws_lb" "dsa_lb" {
    name = "${var.project_name}-lb"
    internal           = false
    load_balancer_type = "application"
    security_groups    = [module.alb-security-group.security_group_id]                
    subnets            = [module.vpc.public_subnets[0], module.vpc.public_subnets[1]] 
}

resource "aws_lb_target_group" "dsa_target_group" {
    name = "${var.project_name}-${var.environment}-target-group"
    port = var.container_port
    protocol = "HTTP"
    target_type = "ip"
    vpc_id = module.vpc.vpc_id

    health_check { #cloud watch usa pra acompanhar o status do target group
        path = var.health_check_path
        port = var.container_port
        protocol = "HTTP"
        matcher = "200-299"
        healthy_threshold = 5
        unhealthy_threshold = 2
        timeout = 5
        interval = 30
    }
}

resource "aws_lb_listener" "ecs-listener" {
  load_balancer_arn = aws_lb.dsa_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.dsa_target_group.arn
  }
}

