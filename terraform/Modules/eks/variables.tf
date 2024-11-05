variable "cluster_name" {
    description     = "The cluster name to use"
    type            = string
    default         = "crypto-cluster"
}

variable "private_subnets" {
  description = "List of private subnet IDs for the EKS node group"
  type        = list(string)
} 

variable "cluster_sg_id"{
    description =   "Cluster security ID"
    type    = string
}
