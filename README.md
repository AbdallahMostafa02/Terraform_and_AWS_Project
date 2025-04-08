# Scalable Multi-Tier AWS Architecture with Web Servers using Terraform

This Terraform project provisions a complete AWS infrastructure for a web application. The architecture is designed to handle traffic securely and efficiently by leveraging both public and private components. When you access the public load balancer URL, traffic is directed to two public EC2 instances which act as reverse proxies by redirecting traffic to a private load balancer. The private load balancer then forwards requests to two private EC2 instances that host the actual web servers.

## Table of Contents
- [Architecture Overview](#architecture-overview)
- [Modules Overview](#modules-overview)
- [Getting Started](#getting-started)
- [Deployment](#deployment)
- [Project Variables](#project-variables)
- [Terraform State Management](#terraform-state-management)
- [Troubleshooting](#troubleshooting)
- [License](#license)

## 🧭 Architecture Overview

The AWS architecture is split into several components to enhance security and manageability:

1. **VPC & Subnets**  
   A dedicated VPC is created with separate public and private subnets across two Availability Zones (AZs).

2. **Internet Gateway & Route Tables**  
   An Internet Gateway is attached to the VPC with route tables that direct internet traffic to the public subnets.

3. **NAT Gateway & Private Route Tables**  
   A NAT Gateway is provisioned in the public subnet, with private route tables sending outbound traffic from private subnets through the NAT.

4. **Security Groups**  
   Security groups are used to control traffic:
   - **Instances Security Group:** Allows SSH (port 22) and HTTP (port 80).
   - **Load Balancer Security Group:** Permits HTTP traffic from the internet.

5. **Data Source**  
   Dynamically retrieves the latest Amazon Linux 2023 AMI for the EC2 instances.

6. **EC2 Instances**  
   - **Public EC2 Instances (2):**  
     Deployed in public subnets and configured with NGINX to act as reverse proxies, forwarding traffic to the private load balancer.
   - **Private EC2 Instances (2):**  
     Located in private subnets, these instances run Apache HTTP server to serve the application content after receiving traffic from the private load balancer.

7. **Load Balancers**  
   - **Public Load Balancer:**  
     Receives incoming internet traffic and distributes it to the public EC2 instances.
   - **Private Load Balancer:**  
     Receives the proxied traffic from public instances and balances it across the private EC2 instances.

8. **Additional Resources**  
   - **S3 Bucket:** Stores the Terraform state.
   - **DynamoDB Table:** Provides state locking for consistent Terraform runs.

## Modules Overview

The repository is organized into multiple modules that abstract the infrastructure components:

- **vpc:** Creates the main VPC.
- **subnets:** Provisions public and private subnets across two AZs.
- **igw:** Creates and attaches an Internet Gateway.
- **route_table:** Sets up a route table for public traffic.
- **private_route_table:** Configures the NAT Gateway and routes for private subnets.
- **security_groups:** Defines security groups for the EC2 instances and load balancers.
- **data_source:** Retrieves the latest public Amazon Linux 2023 AMI.
- **ec2_instances:** Deploys four EC2 instances:
  - Two public instances (configured with NGINX to proxy requests).
  - Two private instances (running Apache to serve web content).
- **load_balancers:** Provisions both public and private Application Load Balancers along with associated target groups and listeners.
- **S3:** Creates an S3 bucket for Terraform state.
- **DynamoDB:** Sets up a DynamoDB table for Terraform state locking.

## Getting Started

### Prerequisites

- **Terraform:** Install [Terraform](https://www.terraform.io/downloads.html) (version 1.x recommended).
- **AWS CLI:** Install and configure the AWS CLI with proper credentials and region settings.
- **SSH Key:** Ensure you have an SSH key pair created in AWS and update the `key_name` and `private_key_path` in the root `variables.tf`.
- **AWS Account:** Confirm your AWS account has permissions to create the required resources (VPCs, EC2 instances, load balancers, etc.).

### Directory Structure

