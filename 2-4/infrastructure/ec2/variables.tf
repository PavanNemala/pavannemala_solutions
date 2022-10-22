# All the variables will be populated by the calling function values

variable "cidr_vpc" {
  description = "CIDR block for the VPC"
}

variable "network_additional_tags" {
  description = "Additional tags for network resources"
}

variable "public_subnets_cidr" {
  description = "Map of subnet number and CIDRs for public subnets"
}

variable "environment_tag" {
  description = "Environment tag"
}

