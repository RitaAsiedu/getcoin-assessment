variable "public_subnet_cidrs" {
    type = list(string)
    description = "Public Subnet CIDR values"
    default = [ "10.20.1.0/24","10.20.2.0/24" ]
}

variable "private_subnet_cidrs" {
  type = list(string)
  description = "Private Subnet CIDR values"
  default = [ "10.20.6.0/24","10.20.8.0/24" ]
}

variable "azs" {
  type = string
  description = "Availability Zones"
  default = "us-east-1"
}