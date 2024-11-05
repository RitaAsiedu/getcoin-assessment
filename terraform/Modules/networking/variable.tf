variable "aws_region" {
    default = "us-east-1"
}

variable "app_name" {
    default = "crypto-app"
}

variable "vpc_cidr" {
    default = "10.0.0.0/16"
}

variable "availability_zones" {
    default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable    "cluster_name"{
    description = "Name of the EKS cluster"
}