#!/bin/bash
set -euo pipefail

echo "Applying Terraform changes for DEV environment..."

cd "envs/dev"

if [ -f "tfplan" ]; then
    terraform apply "tfplan"
else
    terraform apply -auto-approve
fi

echo "Apply complete for dev"
