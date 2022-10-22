# specifies version of terraform required to run the setup
terraform {
  required_version = ">= 1.0.0"
  backend "s3" {
    # Pre-existing bucket name in which to store the terraform state file
    bucket = "test-bucket"
    key = "infrastructure.tfstate"
    region = "us-east-1"
    encrypt = true
    workspace_key_prefix = "Environment"
    profile              = "test"
  }
}

# specifies the provider
provider "aws" {
  region  = var.region
}

module "vpc" {
  count                       = 1
  source                      = "./vpc"
  cidr_vpc                    = var.cidr_vpc
  public_subnets_cidr         = var.public_subnets_cidr
  private_subnets_cidr        = var.private_subnets_cidr
  environment_tag             = var.environment_tag
  network_additional_tags     = var.network_additional_tags

  acceptor_vpc_name = var.vpc_conf.vpc_name

  vpc_flow_logs_conf      = var.vpc_flow_logs_conf
}

module "security_group" {
  source                 = "./security_group"
  vpc_id                 = "${module.vpc.vpc_id}"  
  port                   = var.security_groups.port
  cidr_vpc               = var.cidr_vpc
  environment_tag             = var.environment_tag
  network_additional_tags     = var.network_additional_tags
}

module "ec2_instance" {
  count                  = 1
  source                 = "./ec2"
  ami                    = "amiid"
  instance_type          = "t2.micro"
  monitoring             = true
  vpc_security_group_ids = "${module.security_group.sg_id}" 
  subnet_id              = "${module.vpc.private_subnets_1}" 
  network_additional_tags     = var.network_additional_tags
  environment_tag        = var.environment_tag
}