variable "aws_region" {
  default = "us-east-1"
}

variable "project_name" {
  default = "aws-platform"
}

variable "environment" {
  default = "dev"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnets" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  type    = list(string)
  default = ["10.0.10.0/24", "10.0.11.0/24"]
}

variable "azs" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

variable "ami_id" {
  description = "Amazon Linux 2 AMI"
  default     = "ami-0cff7528ff583bf9a" # us-east-1
}

variable "instance_type" {
  default = "t3.micro"
}
