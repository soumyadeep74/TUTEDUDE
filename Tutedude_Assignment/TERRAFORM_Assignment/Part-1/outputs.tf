output "public_ip" {
  description = "Public IP of EC2 instance"
  value       = aws_instance.part1.public_ip
}
