# Enterprise AWS Multi-Environment Terraform Platform

This repository contains a production-grade, modularized Terraform infrastructure for AWS. It is designed to manage multiple environments (Dev, QA, Staging, Production) with security, scalability, and cost-optimization at its core.

## 🏗 Architecture Overview

The platform is built on a hub-and-spoke model where each environment is isolated within its own VPC.

- **Networking**: VPC with Public and Private subnets across multiple AZs. NAT Gateways for private subnet egress.
- **Compute**: Auto Scaling Groups (ASG) with EC2 instances and Elastic Kubernetes Service (EKS).
- **Load Balancing**: Application Load Balancer (ALB) for traffic distribution.
- **Database**: Managed PostgreSQL via RDS with Multi-AZ for high availability.
- **Storage**: S3 buckets with encryption, versioning, and lifecycle policies.
- **Security**: KMS for encryption, IAM with least privilege, and Secrets Manager.
- **Monitoring**: CloudWatch Dashboards, Alarms, and SNS notifications.

## 📁 Project Structure

```text
terraform-aws-platform/
├── modules/                # Reusable Infrastructure Modules
│   ├── vpc/                # Networking (Subnets, IGW, NAT, RT)
│   ├── ec2/                # Compute (Launch Templates, ASG)
│   ├── s3/                 # Storage (Buckets, Policies)
│   ├── iam/                # Identity (Roles, Policies)
│   ├── rds/                # Database (PostgreSQL)
│   ├── eks/                # Container Orchestration
│   ├── alb/                # Traffic Management
│   ├── kms/                # Encryption Keys
│   └── monitoring/         # Observability (CloudWatch, SNS)
├── envs/                   # Environment Specific Configurations
│   ├── dev/
│   ├── qa/
│   ├── staging/
│   └── prod/
├── backend/                # S3 & DynamoDB Remote State Setup
├── scripts/                # Automation & Helper Scripts
├── policies/               # IAM & Service Control Policies
└── README.md               # You are here
```

## 🚀 Getting Started

### Prerequisites
- AWS CLI configured with appropriate permissions.
- Terraform v1.5+ installed.
- `tflint` and `tfsec` for linting and security scanning.

### 1. Bootstrap the Backend
Before deploying any environment, initialize the remote state:
```bash
cd backend
terraform init
terraform apply
```

### 2. Deploy an Environment (Dev)
```bash
./scripts/init.sh dev
./scripts/plan.sh dev
./scripts/apply-dev.sh
```

## 🛡 Security & Best Practices
- **No Hardcoded Secrets**: Uses AWS Secrets Manager and KMS.
- **Private by Default**: All compute and data resources reside in private subnets.
- **State Locking**: S3 backend with DynamoDB locking to prevent concurrent runs.
- **Immutable Infrastructure**: Changes are applied via Terraform only.
- **Encryption**: KMS encryption enabled for RDS, S3, and EBS.

## 💰 Cost Optimization
- **Auto Scaling**: Right-sizing instances based on load.
- **Lifecycle Policies**: Automated S3 tiering.
- **Spot Instances**: Optional support for non-production environments.
- **Resource Tagging**: Mandatory tags for cost allocation.
