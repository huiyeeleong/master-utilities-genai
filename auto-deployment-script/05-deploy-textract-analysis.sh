#!/bin/bash

# Variables (customize these as needed)
STACK_NAME="textract-analysis-stack"
TEMPLATE_FILE="../infra/02-usecase-1-2/textract-analysis.yaml"

# Check if the CloudFormation template file exists
if [ ! -f "$TEMPLATE_FILE" ]; then
    echo "Error: CloudFormation template file '$TEMPLATE_FILE' does not exist."
    exit 1
fi

# Deploy CloudFormation stack
aws cloudformation deploy \
    --template-file $TEMPLATE_FILE \
    --stack-name $STACK_NAME \
    --capabilities CAPABILITY_NAMED_IAM

echo "Lambda function deployed successfully."
