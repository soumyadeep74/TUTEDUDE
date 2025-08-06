variable "aws_profile" {
  description = "AWS CLI profile name"
  type        = string
  default     = "default"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "key_name" {
  description = "Name of the existing EC2 key pair"
  type        = string
  default     = "course-key"
}

variable "ami_id" {
  type        = string
  default     = "ami-0f918f7e67a3323f0"
  description = "AMI ID"
}

variable "backend_port" {
  description = "Port for Flask backend"
  default     = 5000
}

variable "frontend_port" {
  description = "Port for Express frontend"
  default     = 3000
}

variable "environment" {
  description = "Deployment environment"
  default     = "test"
}

variable "aws_account_id" {
  description = "AWS Account ID"
  type        = string
  default     = "577165021148"
}