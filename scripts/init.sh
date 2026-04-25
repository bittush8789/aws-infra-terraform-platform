#!/bin/bash
set -euo pipefail

# Enterprise Terraform Initialization Script
# Usage: ./init.sh <env>

ENV=$1

if [ -z "$ENV" ]; then
    echo "Usage: ./init.sh <dev|qa|staging|prod>"
    exit 1
fi

echo "Initializing environment: $ENV"

cd "envs/$ENV"

# Assuming bucket and table names are standardized or passed via env vars
terraform init \
    -backend-config="key=$ENV/terraform.tfstate" \
    -reconfigure

echo "Terraform initialized successfully for $ENV"
