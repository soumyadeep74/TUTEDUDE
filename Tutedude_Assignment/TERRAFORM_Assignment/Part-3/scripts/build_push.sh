#!/bin/bash

AWS_REGION="ap-south-1"
ACCOUNT_ID="577165021148"
REPO_BACKEND="flask-backend-test"
REPO_FRONTEND="express-frontend-test"

# Login to ECR
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com

# Build backend
cd /c/Users/soumy/TUTEDUDE/Tutedude_Assignment/TERRAFORM_Assignment/Part-3/backend
docker build -t flask-backend .
docker tag flask-backend:latest $ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$REPO_BACKEND:latest
docker push $ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$REPO_BACKEND:latest

# Build frontend
cd /c/Users/soumy/TUTEDUDE/Tutedude_Assignment/TERRAFORM_Assignment/Part-3/frontend
docker build -t express-frontend .
docker tag express-frontend:latest $ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$REPO_FRONTEND:latest
docker push $ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$REPO_FRONTEND:latest
