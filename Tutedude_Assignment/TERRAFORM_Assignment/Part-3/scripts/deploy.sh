#!/bin/bash
export AWS_REGION=ap-south-1
export ENVIRONMENT=test 

cd /c/Users/soumy/TUTEDUDE/Tutedude_Assignment/TERRAFORM_Assignment/Part-3/terraform

# Initialize Terraform
terraform init

# Validate the Terraform configuration
terraform validate

# Plan the deployment
terraform plan -var="aws_region=$AWS_REGION" -var="environment=$ENVIRONMENT"

# Apply the changes
terraform apply -auto-approve -var="aws_region=$AWS_REGION" -var="environment=$ENVIRONMENT"

# Output the ALB DNS name
terraform output alb_dns_name