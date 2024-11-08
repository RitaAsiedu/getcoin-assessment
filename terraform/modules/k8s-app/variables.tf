variable "aws_region" {
    default = "us-east-1"
}

variable "app_name" {
    description     = "Name of the application"
    type    = string
}

variable "availability_zones" {
    default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable    "eks_cluster_name"{
    description = "Name of the EKS cluster"
    type        = string
}

variable "image_url" {
    description = "Image URL"
    type        = string
}

variable "image_tag" {
  description = "The tag for the container image"
  default     = "latest"
}