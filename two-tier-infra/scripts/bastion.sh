#!/bin/bash
set -e  # Exit on any error

# Update & Install Dependencies (Ansible, Python, AWS CLI)
sudo apt update -y
sudo apt install -y unzip python3-pip ansible

# Install AWS CLI (with --update to avoid conflicts)
curl -s "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip -q awscliv2.zip
sudo ./aws/install --update  # Fixes "preexisting AWS CLI" warning
rm -rf awscliv2.zip aws

# Ensure AWS CLI is in PATH (not always needed, but safe)
export PATH="/usr/local/bin:$PATH"

# Install Boto3 and Botocore SYSTEM-WIDE (for root/Ansible)
sudo python3 -m pip install --upgrade pip
sudo python3 -m pip install --upgrade boto3 botocore

# Install Ansible AWS Collection (for EC2 automation)
ansible-galaxy collection install amazon.aws

