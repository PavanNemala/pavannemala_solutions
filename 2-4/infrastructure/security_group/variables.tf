# All the variables will be populated by the calling function values

variable "cidr_vpc" {
  description = "CIDR block for the SG"
}

variable "port" {
  description = "INBOUND PORT"
}

variable "vpc_id" {
  description = "VPC ID for SG"
}