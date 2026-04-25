#!/bin/bash
set -euo pipefail

ENV=$1

if [ -z "$ENV" ]; then
    echo "Usage: ./plan.sh <env>"
    exit 1
fi

echo "Running Terraform Plan for $ENV"

cd "envs/$ENV"
terraform plan -out=tfplan

echo "Plan saved to envs/$ENV/tfplan"
