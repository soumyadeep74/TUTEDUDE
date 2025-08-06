# PART-2 Flask + Express Deployment using Terraform

This project provisions two EC2 instances:

- One runs a Flask backend (port 5000)
- One runs an Express frontend (port 3000)

## Steps to Deploy

### 1. Create S3 and DynamoDB for Terraform backend

```bash
cd remote
terraform init
terraform apply

### 2. Terraform backend

cd ..
terraform init
terraform plan -out=infra.tfplan (linux) and terraform plan -out infra.tfplan (powershell)
terraform apply infra.tfplan
