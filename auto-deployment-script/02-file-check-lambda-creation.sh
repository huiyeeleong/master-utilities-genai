#!/bin/bash

# Variables (customize these as needed)
LAMBDA_FUNCTION_NAME="file-pages-validation"
IMAGE_NAME="file-pages-validation"
AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
REGION="us-east-1"
ECR_REPOSITORY_NAME="file-pages-validation"
DOCKER_CONTEXT_PATH="infra/01-file-check"

# Create ECR repository if it doesn't exist
aws ecr describe-repositories --repository-names $ECR_REPOSITORY_NAME > /dev/null 2>&1

if [ $? -ne 0 ]; then
    aws ecr create-repository --repository-name $ECR_REPOSITORY_NAME
fi

# Get the login command from ECR and execute it directly
$(aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com)

# Build the Docker image
docker build -t $IMAGE_NAME $DOCKER_CONTEXT_PATH

# Tag the Docker image
docker tag $IMAGE_NAME:latest $AWS_ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/$ECR_REPOSITORY_NAME:latest

# Push the Docker image to ECR
docker push $AWS_ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/$ECR_REPOSITORY_NAME:latest

# Update the Lambda function to use the new image
# aws lambda update-function-code --function-name $LAMBDA_FUNCTION_NAME --image-uri $AWS_ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/$ECR_REPOSITORY_NAME:latest

# echo "Lambda function updated with the new Docker image."
