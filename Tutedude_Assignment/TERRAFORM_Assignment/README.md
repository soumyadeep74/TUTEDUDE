
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
