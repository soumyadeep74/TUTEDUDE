
# PART-1 Flask + Express Deployment on Single EC2 with Terraform

This project provisions an EC2 instance using Terraform and deploys:
- A **Flask backend** on port `5000`
- An **Express frontend** on port `3000`

## Steps to Deploy
cd Part-1
terraform init
terraform validate
terraform apply 
terraform destroy

====================================================================


# PART-2 Flask + Express Deployment on Two seprate EC2 using Terraform

This project provisions two EC2 instances:

- One runs a Flask backend (port 5000)
- One runs an Express frontend (port 3000)

## Steps to Deploy
cd Part-2
### 1. Create S3 and DynamoDB for Terraform backend

```bash
cd remote_state
terraform init
terraform validate
terraform apply

### 2. Terraform backend

cd ..
terraform init
terraform validate
terraform plan -out=infra.tfplan (linux) and terraform plan -out infra.tfplan (powershell)
terraform apply infra.tfplan


### 3. Delete all resource

terraform destroy
cd remote_state
terraform destroy

====================================================================

# Part-3 Flask + Express Deployment on AWS using Docker, ECS, and Terraform

Deploy a **Flask backend** and an **Express frontend** as Docker containers using:

- **AWS ECR** – Docker image registry
- **AWS ECS (Fargate)** – Container orchestration
- **AWS VPC** – Network infrastructure
- **AWS ALB** – Application Load Balancer
- **Terraform** – Infrastructure as Code
- **Bash Scripts** – Automate Docker builds and deployment

---

##  Prerequisites

Ensure the following tools are installed and configured:

- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) (authenticated with IAM user/role)
- [Terraform](https://developer.hashicorp.com/terraform/downloads)
- [Docker](https://docs.docker.com/get-docker/)
- Bash shell (Linux/macOS or WSL on Windows)

cd Part-3
cd scripts/
terraform init
terraform validate
terraform apply
#Build and push Docker images
chmod +x build_push.sh
./build_push.sh
#Deploy infrastructure
chmod +x deploy.sh
./deploy.sh