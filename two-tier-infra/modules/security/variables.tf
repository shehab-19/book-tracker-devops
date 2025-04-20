variable "vpc-id" { 

}

variable "ami" {
    default = "ami-053b0d53c279acc90"  # Ubuntu 22.04 LTS AMI in us-east-1
}

variable "instance_type" {
    default = "t2.micro"
}

variable "make_bastion" {
    type = bool
}

variable "bastion-public-subnet" {
  
}

variable "user_data" {
}