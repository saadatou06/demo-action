#!/bin/bash

set -e

# Variables
BUCKET_NAME="$1"
AWS_REGION="$2"

if [[ -z "$BUCKET_NAME" || -z "$AWS_REGION" ]]; then
  echo "Usage: $0 <bucket-name> <aws-region>"
  exit 1
fi

# Check if bucket already exists
echo "Checking if bucket $BUCKET_NAME exists..."

if aws s3api head-bucket --bucket "$BUCKET_NAME" 2>/dev/null; then
  echo "Bucket $BUCKET_NAME already exists. Skipping creation."
else
  echo "Bucket $BUCKET_NAME does not exist. Creating..."
  aws s3api create-bucket \
    --bucket "$BUCKET_NAME" \
    --region "$AWS_REGION" 
  echo "Bucket $BUCKET_NAME created successfully."
fi
