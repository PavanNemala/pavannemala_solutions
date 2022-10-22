variable "acceptor_vpc_name" {
  description = "Name of acceptor VPC"
}

variable "cidr_vpc" {
  description = "CIDR block for the VPC"
}

variable "network_additional_tags" {
  description = "Additional tags for network resources"
}

variable "public_subnets_cidr" {
  description = "Map of subnet number and CIDRs for public subnets"
}

variable "private_subnets_cidr" {
  description = "Map of subnet number and CIDRs for EKS nodes"
}

variable "environment_tag" {
  description = "Environment tag"
}
