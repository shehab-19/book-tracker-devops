variable "vpc-id" { 
}

variable "ami" {
    default = "ami-053b0d53c279acc90"  # Ubuntu 22.04 LTS AMI in us-east-1
}

variable "instance_type" {
    default = "t2.micro"
}

variable "key_name" {
}

variable "web_sg" { 
}

variable "alb_sg" {  
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "max_size" {
 
}

variable "min_size" {
  
}

variable "desired_capacity" {
  
}