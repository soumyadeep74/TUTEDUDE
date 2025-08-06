##################################################
# Check if ecsTaskExecutionRole IAM role exists
##################################################
data "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"
}

##################################################
# Create ecsTaskExecutionRole if not exists
##################################################
resource "aws_iam_role" "ecs_task_execution_role" {
  count = length(try([data.aws_iam_role.ecs_task_execution_role.name], [])) == 1 ? 0 : 1

  name = "ecsTaskExecutionRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

##################################################
# Attach ECS task execution policy if role created
##################################################
resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  count      = length(aws_iam_role.ecs_task_execution_role) == 0 ? 0 : 1
  role       = aws_iam_role.ecs_task_execution_role[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

##################################################
# Local variable for execution role ARN (existing or newly created)
##################################################
locals {
  ecs_execution_role_arn = (
    length(try([data.aws_iam_role.ecs_task_execution_role.arn], [])) == 1 ?
    data.aws_iam_role.ecs_task_execution_role.arn :
    aws_iam_role.ecs_task_execution_role[0].arn
  )
}

##################################################
# ECS Cluster
##################################################
resource "aws_ecs_cluster" "main" {
  name = "flask-express-cluster"
}

##################################################
# Backend Task Definition
##################################################
resource "aws_ecs_task_definition" "backend" {
  family                   = "backend-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = local.ecs_execution_role_arn

  container_definitions = jsonencode([{
    name      = "flask-backend"
    image     = "${var.aws_account_id}.dkr.ecr.${var.aws_region}.amazonaws.com/flask-backend-test:latest"
    cpu       = 256
    memory    = 512
    essential = true
    portMappings = [{
      containerPort = var.backend_port
      hostPort      = var.backend_port
    }]
  }])
}

##################################################
# Frontend Task Definition
##################################################
resource "aws_ecs_task_definition" "frontend" {
  family                   = "frontend-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = local.ecs_execution_role_arn

  container_definitions = jsonencode([{
    name      = "express-frontend"
    image     = "${var.aws_account_id}.dkr.ecr.${var.aws_region}.amazonaws.com/express-frontend-test:latest"
    cpu       = 256
    memory    = 512
    essential = true
    portMappings = [{
      containerPort = var.frontend_port
      hostPort      = var.frontend_port
    }]
  }])
}

##################################################
# Backend ECS Service
##################################################
resource "aws_ecs_service" "backend" {
  name            = "backend-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.backend.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    security_groups = [aws_security_group.ecs.id]
    subnets         = aws_subnet.public[*].id
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.backend.arn
    container_name   = "flask-backend"
    container_port   = var.backend_port
  }

  depends_on = [aws_lb_listener.backend]
}

##################################################
# Frontend ECS Service
##################################################
resource "aws_ecs_service" "frontend" {
  name            = "frontend-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.frontend.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    security_groups = [aws_security_group.ecs.id]
    subnets         = aws_subnet.public[*].id
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.frontend.arn
    container_name   = "express-frontend"
    container_port   = var.frontend_port
  }

  depends_on = [aws_lb_listener.frontend]
}
