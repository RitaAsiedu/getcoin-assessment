output "vpc_id" {
    value   = aws_vpc.main.id 
    description = "The ID of the VPC"
}

output "public_subnet_ids" {
  value       = aws_subnet.public[*].id
  description = "List of private subnet IDs"
} 

output "cluster_sg_id" {
  value       = aws_security_group.eks_cluster.id
  description = "Security group ID for EKS cluster"
}

output "eks_nodes_sg_id" {
  value       = aws_security_group.eks_nodes.id
  description = "Security group ID for EKS nodes"
}

