# Kubernetes provider configuration
provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = module.eks.cluster_ca_certificate
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args = [
      "eks",
      "get-token",
      "--cluster-name",
      module.eks.cluster_name
    ]
  }
}

module "networking" {
  source = "./modules/networking"
  vpc_cidr           = var.vpc_cidr
  availability_zones = var.availability_zones
  cluster_name        = module.eks.cluster_name
}

module "ecr" {
  source = "./modules/ecr"
  
  repository_name = var.repository_name
}

module "eks" {
  source = "./modules/eks"
  
  public_subnets = module.networking.public_subnet_ids
  cluster_sg_id   = module.networking.cluster_sg_id
 # node_group_sg   = module.networking.eks_node_group_sg_id
}


module "docker" {
  source          = "./modules/docker"

  ecr_repository_url = module.ecr.repository_url
  docker_context_path = "${path.root}/../python-app"
  dockerfile_path = "Dockerfile"
  aws_region = var.aws_region
} 

module "k8s_app" {
  source = "./modules/k8s-app"
  
  app_name        = var.app_name
  image_url       = "${module.ecr.repository_url}:latest"
  eks_cluster_name = module.eks.cluster_name

  depends_on = [module.docker]
} 

output "application_endpoint"{
  value = "http://${module.k8s_app.load_balancer_hostname}"
  description = "dns name of the load balancer"
  
}
# added a comment