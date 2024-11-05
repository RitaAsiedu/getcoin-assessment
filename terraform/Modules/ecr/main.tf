resource "aws_ecr_repository" "app" {
  name = var.repository_name
  
  image_scanning_configuration {
    scan_on_push = true
  }
} 

output "repository_url" {
  value = aws_ecr_repository.app.repository_url
}
#comment out