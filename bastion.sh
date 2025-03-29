#!/bin/bash
sudo apt update -y && sudo apt install -y unzip python3-pip
echo "Installing AWS CLI..."
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm -rf awscliv2.zip aws
aws --version
pip3 install --upgrade boto3 botocore ansible amazon.aws
