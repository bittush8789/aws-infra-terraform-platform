# 🌐 Terraform Multi-Environment AWS Platform

[![Terraform Version](https://img.shields.io/badge/terraform-%3E%3D1.5.0-623CE4.svg?logo=terraform)](https://www.terraform.io/)
[![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?logo=amazon-aws&logoColor=white)](https://aws.amazon.com/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![CI/CD](https://github.com/bittush8789/aws-infra-terraform-platform/actions/workflows/terraform.yml/badge.svg)](https://github.com/bittush8789/aws-infra-terraform-platform/actions)

## 📋 Table of Contents
- [Project Overview](#-project-overview)
- [Key Features](#-key-features)
- [Architecture](#-architecture)
- [Folder Structure](#-folder-structure)
- [Prerequisites](#-prerequisites)
- [Quick Start](#-quick-start)
- [Multi-Environment Strategy](#-multi-environment-strategy)
- [Security Best Practices](#-security-best-practices)
- [CI/CD Pipeline](#-cicd-pipeline)
- [Cost Optimization](#-cost-optimization)
- [Monitoring & Alerting](#-monitoring--alerting)
- [Cleanup](#-cleanup)
- [License](#-license)

---

## 🚀 Project Overview

This repository contains a **production-ready**, modularized AWS infrastructure platform managed via Terraform. It is designed to empower DevOps teams to provision and manage multiple isolated environments (Dev, QA, Staging, Production) with consistency, security, and scalability.

By leveraging **Terraform Modules**, this project avoids code duplication and follows the **DRY (Don't Repeat Yourself)** principle, making it easy to maintain and evolve.

## ✨ Key Features

- **Isolated Environments**: Environment-specific configurations for full isolation.
- **Remote State Locking**: Secure state management using S3 and DynamoDB.
- **High Availability**: Multi-AZ deployments for networking, RDS, and EKS.
- **Zero-Trust Security**: Private-by-default networking, KMS encryption, and IAM least-privilege.
- **Automated CI/CD**: Full GitHub Actions pipeline for linting, security scanning, and deployment.
- **Scalable Compute**: Auto Scaling Groups (ASG) and Elastic Kubernetes Service (EKS).

---

## 🏗 Architecture

The platform implements a **Hub-and-Spoke** networking model where each environment resides in a dedicated VPC across multiple Availability Zones.

- **Networking**: VPC with Public (ALB/Bastion) and Private (App/DB) subnets.
- **Load Balancing**: Application Load Balancer (ALB) for SSL termination and traffic routing.
- **Database Layer**: Amazon RDS (PostgreSQL) with Multi-AZ failover and encrypted storage.
- **Compute Layer**: ASG for stateless EC2 instances and EKS for containerized workloads.
- **Storage Layer**: Encrypted S3 buckets with intelligent lifecycle policies.

---

## 📂 Folder Structure

```text
terraform-aws-platform/
├── .github/workflows/      # GitHub Actions CI/CD pipelines
├── modules/                # Reusable, versioned infrastructure modules
│   ├── vpc/                # VPC, Subnets, NAT, IGW
│   ├── ec2/                # Launch Templates & Auto Scaling Groups
│   ├── rds/                # Managed PostgreSQL Instance
│   ├── eks/                # EKS Cluster & Node Groups
│   ├── alb/                # Application Load Balancer & Target Groups
│   ├── s3/                 # Encrypted Storage Buckets
│   ├── iam/                # IAM Roles & Instance Profiles
│   ├── kms/                # Encryption Keys (CMK)
│   └── monitoring/         # CloudWatch Alarms & SNS Topics
├── envs/                   # Environment-specific orchestrators
│   ├── dev/                # Development environment variables & state
│   ├── qa/                 # QA environment configuration
│   ├── staging/            # Staging environment configuration
│   └── prod/               # Production environment (High Availability)
├── backend/                # S3 + DynamoDB Bootstrap for Remote State
├── scripts/                # Automation & helper shell scripts
└── README.md               # Project documentation
```

---

## 🛠 Prerequisites

Before you begin, ensure you have the following installed and configured:

1.  **Terraform**: `v1.5.0` or higher.
2.  **AWS CLI**: Configured with an IAM user having `AdministratorAccess`.
3.  **tflint**: For Terraform linting.
4.  **tfsec**: For security static analysis.
5.  **Git**: To manage version control.

---

## 🏁 Quick Start

### 1. Bootstrap Remote State
Initialize the S3 bucket and DynamoDB table for state locking:
```bash
cd backend
terraform init
terraform apply -auto-approve
```

### 2. Deploy Development Environment
```bash
./scripts/init.sh dev
./scripts/plan.sh dev
./scripts/apply-dev.sh
```

---

## 🛡 Security Best Practices

We implement industry-standard security patterns:
- **Encryption at Rest**: AES-256 encryption via AWS KMS for all data-bearing resources.
- **Encryption in Transit**: TLS/SSL termination at the ALB.
- **Network Isolation**: All databases and applications are in **Private Subnets**.
- **IAM Hardening**: No hardcoded credentials; uses IAM roles and Instance Profiles.
- **Audit Logging**: CloudWatch logs enabled for all critical resources.

## 🤖 CI/CD Pipeline

The `.github/workflows/terraform.yml` performs:
1.  **Static Analysis**: `terraform fmt` and `terraform validate`.
2.  **Security Audit**: `tfsec` scans for misconfigurations.
3.  **Linting**: `tflint` checks for AWS best practices.
4.  **Dry Run**: `terraform plan` with artifact upload.
5.  **Manual Approval**: Deployment to production requires human intervention.

## 💰 Cost Optimization

- **Auto Scaling**: Dynamically scales EC2 instances based on demand.
- **Lifecycle Policies**: Automatically transitions old logs and data to S3 Glacier.
- **Right-Sizing**: Default instances are set to `t3.micro` for Dev/QA.
- **Tagging**: Standardized `Environment` and `Project` tags for cost allocation tags in AWS Billing.

---

## 📊 Monitoring & Alerting

- **CloudWatch Alarms**: Monitors CPU, Memory, and Disk usage.
- **RDS Health**: Alerts on database CPU utilization and low storage.
- **SNS Notifications**: Real-time email/Slack alerts for infrastructure events.

---

## 🧹 Cleanup

To avoid ongoing AWS costs, destroy the infrastructure when finished:
```bash
./scripts/destroy-dev.sh
```

---

## 📜 License

Distributed under the MIT License. See `LICENSE` for more information.

---

## 📬 Contact

**Bittu Sharma** - [GitHub](https://github.com/bittush8789) - [LinkedIn](https://linkedin.com/in/bittusharma)

*Project Link: [https://github.com/bittush8789/aws-infra-terraform-platform](https://github.com/bittush8789/aws-infra-terraform-platform)*
