variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
  default     = "cryptos3bucket"
} 

variable "state_bucket" {
  description = "Name of the S3 bucket for Terraform state"
  type        = string
}

variable "state_key" {
  description = "Key for the Terraform state file in the S3 bucket"
  type        = string
}