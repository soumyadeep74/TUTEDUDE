output "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  value       = aws_lb.main.dns_name
}

output "backend_url" {
  description = "URL for the Flask backend service"
  value       = "http://${aws_lb.main.dns_name}:${var.backend_port}"
}

output "frontend_url" {
  description = "URL for the Express frontend service"
  value       = "http://${aws_lb.main.dns_name}:${var.frontend_port}"
}