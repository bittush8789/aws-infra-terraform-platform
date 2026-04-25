#!/bin/bash
set -euo pipefail

# This script demonstrates using workspaces instead of separate directories
# Note: The current project uses separate directories (envs/), but this script
# shows how you WOULD switch if using a workspace-based strategy.

WORKSPACE=$1

if [ -z "$WORKSPACE" ]; then
    echo "Usage: ./switch-workspace.sh <name>"
    exit 1
fi

echo "Switching to Terraform Workspace: $WORKSPACE"

terraform workspace select "$WORKSPACE" || terraform workspace new "$WORKSPACE"

echo "Workspace is now set to $(terraform workspace show)"
