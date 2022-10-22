# General Variables
region  = "us-east-1"
profile = "test"

# Tag for environment
environment_tag = "test"

# All Network variables
vpc_conf = {
  vpc_name             = "test_vpc"
  public_subnets_names = ["test_public_subnet_1", "test_public_subnet_2"]
  private_subnets_names    = ["test_private_subnet_1", "test_private_subnet_2"]
}

cidr_vpc = "10.1.0.0/16"

network_additional_tags = {
  product      = "test"
  workloadtype = "network"
  owner        = "pavan"
}

# Specify all CIDRs you wish to keep for Public subnets. Number of CIDRs, that many subnets will be created
public_subnets_cidr = {
  "0" = { cidr = "10.1.0.0/20" },
  "1" = { cidr = "10.1.16.0/20" },
}

#  Specify all CIDRs you wish to keep for Private subnets. Number of CIDRs, that many subnets will be created
private_subnets_cidr = {
  "0" = { cidr = "10.1.48.0/20" },
  "1" = { cidr = "10.1.64.0/20" },
}

security_groups = {
  port  = 22
}



