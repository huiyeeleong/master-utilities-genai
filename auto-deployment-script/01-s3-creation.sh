#!/bin/bash

# Prompt the user for the bucket name and region
read -p "Enter the bucket name: " BUCKET_NAME
read -p "Enter the AWS region (e.g., us-west-2): " REGION

# Create the S3 bucket
if [ "$REGION" == "us-east-1" ]; then
    aws s3api create-bucket --bucket $BUCKET_NAME --region $REGION
else
    aws s3api create-bucket --bucket $BUCKET_NAME --region $REGION --create-bucket-configuration LocationConstraint=$REGION
fi

# Check if the bucket was created successfully
if [ $? -eq 0 ]; then
    echo "Bucket '$BUCKET_NAME' created successfully in region '$REGION'."
else
    echo "Failed to create bucket '$BUCKET_NAME'."
fi

# List all S3 buckets to confirm
aws s3 ls
