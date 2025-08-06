##################################################
# Security Group for ALB
##################################################
resource "aws_security_group" "alb" {
  name        = "alb-security-group"
  description = "Allow internet access to ALB"
  vpc_id      = aws_vpc.main.id

  # Allow HTTP traffic (backend listener)
  ingress {
    description = "Allow HTTP traffic on port 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow frontend traffic (port 3000 or whatever var.frontend_port is)
  ingress {
    description = "Allow frontend traffic"
    from_port   = var.frontend_port
    to_port     = var.frontend_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "alb-sg"
  }
}

##################################################
# Application Load Balancer
##################################################
resource "aws_lb" "main" {
  name               = "flask-express-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = aws_subnet.public[*].id

  enable_deletion_protection = false

  tags = {
    Name = "flask-express-alb"
  }
}

##################################################
# Backend Target Group
##################################################
resource "aws_lb_target_group" "backend" {
  name        = "backend-tg"
  port        = var.backend_port
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "ip"

  health_check {
    path                = "/health"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
    matcher             = "200"
  }

  tags = {
    Name = "backend-tg"
  }
}

##################################################
# Frontend Target Group
##################################################
resource "aws_lb_target_group" "frontend" {
  name        = "frontend-tg"
  port        = var.frontend_port
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "ip"

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
    matcher             = "200"
  }

  tags = {
    Name = "frontend-tg"
  }
}

##################################################
# Backend Listener (Port 80)
##################################################
resource "aws_lb_listener" "backend" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend.arn
  }
}

##################################################
# Frontend Listener (Port 3000 or custom port)
##################################################
resource "aws_lb_listener" "frontend" {
  load_balancer_arn = aws_lb.main.arn
  port              = var.frontend_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend.arn
  }
}
