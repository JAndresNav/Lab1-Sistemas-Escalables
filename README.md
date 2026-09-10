# Lab1 — EC2 + Nginx with Terraform

Terraform configuration for a Diseño de Sistemas Escalables (ITESO) lab. It provisions a single free-tier EC2 instance on AWS, installs and starts Nginx via user data, and stores remote state in a shared S3 bucket.

## What it creates

- An `aws_instance` running the latest Amazon Linux 2023 AMI (`t2.micro` by default), in the account's default VPC/subnet.
- A security group allowing inbound SSH (22) and HTTP (80) from anywhere, and all egress.
- A new SSH key pair (`tls_private_key` + `aws_key_pair`), with the private key written locally as `<instance_name>-key.pem`.
- Nginx installed and enabled on boot via `user_data.sh`.

## Requirements

- [Terraform](https://developer.hashicorp.com/terraform/downloads) >= 1.5.0 (S3 native state locking requires >= 1.10)
- An AWS CLI profile with credentials (default profile name: `academy`)

## Usage

```bash
terraform init
terraform plan
terraform apply
```

On success, Terraform prints the instance's public IP/DNS, a ready-to-use SSH command, and the URL of the Nginx default page.

```bash
terraform destroy
```

## Configuration

Variables (see `variables.tf`), all optional:

| Variable        | Default             | Description                          |
|------------------|---------------------|---------------------------------------|
| `aws_region`     | `us-east-1`          | AWS region to deploy into            |
| `aws_profile`    | `academy`            | AWS CLI profile used for auth        |
| `instance_type`  | `t2.micro`           | EC2 instance type                    |
| `instance_name`  | `lab1-ec2-instance`  | Name tag for the instance            |

Override any of them with `-var` or a `*.tfvars` file (tfvars are gitignored).

## Remote state

State is stored in a shared S3 bucket (see the `backend "s3"` block in `versions.tf`) with native S3 locking, so it isn't tracked locally.

## Notes

- The security group opens SSH and HTTP to `0.0.0.0/0` — fine for a short-lived lab, not for production.
- The generated `*.pem` private key and Terraform state/lock files are gitignored and never committed.
