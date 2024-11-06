variable "dockerfile_path" {
  description = "Path to the directory containing the Dockerfile and app.py"
  type        = string
  default     = "Dockerfile"
} 

variable "ecr_repository_url" {
  description = "ECR repository URL"
  type        = string
}

variable "docker_context_path" {
  description = "Docker context path"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}