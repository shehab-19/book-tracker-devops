variable "vpc-name" {
}

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