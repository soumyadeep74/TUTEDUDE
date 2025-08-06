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
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}