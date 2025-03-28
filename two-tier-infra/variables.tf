variable "az" {
    type        = list(string)
    default     = ["us-east-1a", "us-east-1b" ]
}

variable "public-subnet-cidr_block" {
    type = map(string)
    default = {

        subnet1  = "10.0.0.0/18"
        subnet2  = "10.0.64.0/18"
}    
}

variable "private-subnet-cidr_block" {
    type = map(string)
    default = {

        subnet1 = "10.0.128.0/18"
        subnet2 = "10.0.192.0/18" 
}
}

variable "public-rtb-name" {
    default = "public-rtb"
}

variable "private-rtb-name" {
    default = "private-rtb"
}

variable "igw-name" {
  default = "custom-igw"
}

variable "vpc-name" {
    default = "my-vpc-2"
}

variable "web-ec2-name" {
    type = list(string)
    default = ["web-1", "web-2"]
  
}

variable "ami" {
    default = "ami-053b0d53c279acc90"  # Ubuntu 22.04 LTS AMI in us-east-1
    type    = string
}

variable "t2-instance_type" {
    default = "t2.micro"
    type    = string
}

variable "db-name" {
  default = "bookstore"
}

variable "db-identifier" {
  default = "database01"
}