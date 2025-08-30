CA 1 IT Infrastructure & Automation

This repo contains a Terraform proof-of-concept that stands up a small, production-like web stack on AWS

What this repo builds:

- 1 x VPC with 2 public + 2 private subnets across 2 AZs
- Internet Gateway and a single NAT Gateway (to keep costs down)
- Application Load Balancer (ALB) in public subnets
- Auto Scaling Group of EC2 instances (Amazon Linux 2023) in private subnets
- RDS MySQL instance in private subnets
- Security Groups and IAM roles
- CloudWatch Logs + a basic ALB 5xx alarm

Extras
- AWS WAF with AWS managed core rules attached to the ALB
- S3 access logs for ALB
