# DevOps-Learning-Terraform

## Terraform WordPress Deployment on AWS
### 📌 Project Overview

This project demonstrates how Terraform can be used to provision and manage real AWS infrastructure end-to-end using Infrastructure as Code (IaC).

Using Terraform, I deployed an EC2 instance running WordPress, configured networking and security, automated software installation using user data, validated the deployment via a public endpoint, and then safely destroyed the infrastructure to avoid unnecessary costs.

This project focuses on understanding how Terraform works, how resources relate to each other, and how to structure Terraform code in a clean, production-style way.

### 🌍 What is Terraform?

Terraform is an Infrastructure as Code (IaC) tool that allows you to define cloud infrastructure using declarative configuration files.
Instead of clicking through the AWS Console, Terraform enables you to:
- Define infrastructure in code
- Version control infrastructure
- Recreate environments consistently
- Safely create, update, and destroy resources
- Terraform follows a simple but powerful workflow:
- plan – preview what Terraform will create or change
- apply – create the infrastructure
- destroy – tear everything down cleanly

### 🏗️ Architecture Overview

The infrastructure deployed in this project includes:

- AWS EC2 instance (t2.micro)
- Default VPC (172.31.0.0/16)
- Public subnet in ca-central-1a
- Security Group allowing HTTP (port 80)
- WordPress + Apache + PHP + MariaDB installed via user data

All resources were provisioned entirely via Terraform.

### 📁 Project Structure

<img width="1024" height="1024" alt="image" src="https://github.com/user-attachments/assets/a62b0161-f8ac-47aa-9a4d-99b980193920" />


### 🧩 Terraform Files Explained
#### main.tf:

This file defines the core infrastructure:

- AWS provider configuration
- EC2 instance resource
- Security Group resource
- Association between EC2 and Security Group
- User data script execution

This is where the actual infrastructure logic lives.

#### variables.tf

This file defines input variables that can change between environments.

In this project it is used for:

- EC2 instance type

Using variables makes the configuration more flexible and reusable.

#### outputs.tf

This file exposes useful information after Terraform runs.

Example output:

- EC2 instance ID

Outputs make it easier to retrieve important details without digging through the AWS Console.

#### install_wordpress.sh

This script is passed to the EC2 instance using Terraform user data.

It automates:

- OS updates
- Apache, PHP, and MariaDB installation
- WordPress installation and configuration
- File permissions
- Service startup

This ensures the EC2 instance is fully configured automatically at launch.

⚠️ Note: Secrets are replaced with placeholders before committing to GitHub.

### 🚀 Terraform Workflow Used

<img width="518" height="164" alt="image" src="https://github.com/user-attachments/assets/bf4191a4-6cb7-4c99-a68d-ed531bdb9716" />


This workflow ensures changes are intentional, visible, and reversible.

### 🧠 Key Learnings

- How Terraform manages resource dependencies automatically
- How to structure Terraform projects cleanly
- How to attach security groups to EC2 using references
- How to automate software installation with user data
- Why Terraform state files should never be committed
- How to safely destroy infrastructure to control costs

### 🧹 Clean-Up & Cost Control

All resources were destroyed using:

- terraform destroy

This ensures no ongoing AWS charges and reflects real-world DevOps best practices.

### 🔮 Next Steps

Future improvements could include:

- Moving secrets to AWS SSM or Terraform variables
- Adding an Application Load Balancer
- Using RDS instead of local MariaDB
- Introducing remote Terraform state

### 📎 Notes

This project focuses on Terraform fundamentals and infrastructure design, not WordPress development itself.

The goal was to understand how Terraform manages real cloud infrastructure end-to-end.

### 🧩 Architecture Diagram

The diagram below represents the final architecture deployed using Terraform in this project.

It shows:

- Terraform provisioning AWS resources
- An EC2 instance running WordPress
- Security Group allowing HTTP (port 80)
- Traffic flow from the public internet to the application

<img width="1024" height="1536" alt="wordpress" src="https://github.com/user-attachments/assets/f6db367c-26ef-4900-b343-3f10e32d624b" />


👨‍💻 Built as part of my ongoing DevOps & Cloud Engineering learning journey.
