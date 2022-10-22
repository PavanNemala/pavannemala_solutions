# General Variables

variable "region" {
  description = "Specifies the region for the deployment"
}

variable "profile" {
  description = "AWS Profile to use"
}

variable "environment_tag" {
  description = "Environment tag"
}

# New vpc

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
  description = "Map of subnet number and CIDRs for private subnets"
}


