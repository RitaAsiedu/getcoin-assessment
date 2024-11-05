# getcoin-assessment
# Crypto App Terraform deployment

This repository contains Terraform configurations for deploying the Crypto App infrastructure on AWS, automated through GitHub Actions.

## Infrastructure Overview

This deployment creates:
- ECS Fargate cluster for containerized applications
- Application Load Balancer for traffic distribution
- RDS PostgreSQL database
- S3 buckets for asset storage
- CloudWatch logging and monitoring
- VPC with public and private subnets

## Prerequisites

- [GitHub Account](https://github.com/)
- [AWS Account](https://aws.amazon.com/)
- Terraform >= 1.0.0
- AWS CLI configured locally (for manual operations)

## Repository Structure

.
├── app/
│   ├── Dockerfile
│   ├── app.py
│   └── requirements.txt
├── k8s-deployment/
│   ├── crypto-cluster.yaml
│   │   ├── manifest/
│   │   │   ├── autoscaler.yaml
│   │   │   ├── deployment.yaml
│   │   │   └── service.yaml
├── terraform/
│   ├── modules/
│   │   ├── docker
│   │   ├── ecr/
│   │   ├── k8s-app/
│   │   ├── eks/
│   │   ├── networking/
│   │   └── s3/
│   ├── main.tf
│   ├── providers.tf
│   └── variables.tf
├── README.md
└── .github/
    └── workflows/
        ├── terraform-deploy.yml
        └── terraform-destroy.yml
```

## Environment Configuration

Each environment (dev/staging/prod) requires:

1. Create AWS credentials:
   ```bash
   AWS_ACCESS_KEY_ID
   AWS_SECRET_ACCESS_KEY
   ```

2. Configure GitHub Secrets:
   - `AWS_ACCESS_KEY_ID`
   - `AWS_SECRET_ACCESS_KEY`
   - `AWS_DEFAULT_REGION`

3. Create S3 bucket for Terraform state:
   - `cryptos3bucket`

## GitHub Actions Workflow

The repository includes a GitHub Actions workflow (`.github/workflows/terraform-deploy.yml`) that:
- Runs on push to main branch and pull requests
- Performs Terraform init, plan, and apply
- Automatically deploys changes when merged to main

## Destroying Infrastructure

### Using GitHub Actions

The repository includes a dedicated workflow for destroying infrastructure safely. This workflow:
- Requires manual trigger
- Requires explicit confirmation
- Needs manual approval before destruction

To destroy infrastructure:

1. Go to the GitHub repository
2. Navigate to the "Actions" tab
3. Select "Terraform Destroy" workflow
4. Click "Run workflow"
5. Fill in the required inputs:
   - Type "DESTROY" in the confirmation field
6. Click "Run workflow"
7. Wait for the plan to complete
8. Review the planned destruction
9. Approve the destruction when prompted