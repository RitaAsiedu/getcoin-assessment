resource "docker_image" "image" {
  name = "${var.ecr_repository_url}:latest"
  build {
    context = var.docker_context_path
    dockerfile = var.dockerfile_path
    tag = ["${var.ecr_repository_url}:latest"]
    no_cache = true
  }
  force_remove = true
}

resource "null_resource" "docker_push" {
  triggers = {
    image_id = docker_image.image.id
  }
  provisioner "local-exec" {
    command = <<EOF
      aws ecr get-login-password --region ${var.aws_region} | docker login --username AWS --password-stdin ${var.ecr_repository_url}
      docker push ${var.ecr_repository_url}:latest
    EOF
  }

  depends_on = [docker_image.image]
}
