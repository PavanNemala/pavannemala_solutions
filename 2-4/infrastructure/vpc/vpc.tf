/*
AWS VPC resource  to create VPC with the cidr block provided
to address dns queries from the instances in VPC, dns_support is enabled
Hostnames for instances are enabled
*/

resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr_vpc
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = merge(
          {
            Name       = "${var.environment_tag}-vpc"
            environment = var.environment_tag
          },
            var.network_additional_tags
          )
}

# internet Gateway is used to enable connection to internet
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = merge(
          {
            Name       = "${var.environment_tag}-vpc-igw"
            environment = var.environment_tag
          },
            var.network_additional_tags
          )
}

data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  # Count of all available Availability Zones in the region
  total_availability_zones = length(data.aws_availability_zones.available.name) 
}

# Creation of Public Subnets
resource "aws_subnet" "subnet_public" {
  for_each = var.public_subnets_cidr
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = each.value.cidr
  map_public_ip_on_launch = "true"
  availability_zone       = data.aws_availability_zones.available.names[each.key % local.total_availability_zones]
  tags = merge({
    Name       = "${var.environment_tag}-public-subnet-${each.key}"
    environment = var.environment_tag
  },
  var.network_additional_tags
  )
}

# Creation of Private Subnets
resource "aws_subnet" "subnet_private" {
  for_each = var.private_subnets_cidr
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = each.value.cidr
  availability_zone       = data.aws_availability_zones.available.names[each.key % local.total_availability_zones]
  tags = merge({
    Name       = "${var.environment_tag}-private-subnet-${each.key}"
    environment = var.environment_tag
  },
  var.network_additional_tags
  )
}

# Creation of Elastic IPs for individual NAT
resource "aws_eip" "natA" {
  vpc = true
  tags = merge(
          {
            Name       = "${var.environment_tag}-NAT-GW-eip-0"
            environment = var.environment_tag
          },
            var.network_additional_tags
          )
}


# Creation of NAT gateways for instances in private subnets to be able to connect to internet
resource "aws_nat_gateway" "ngwA" {
  allocation_id = aws_eip.natA.id
  subnet_id     = aws_subnet.subnet_public[0].id
  depends_on    = [aws_internet_gateway.igw]
  tags = merge(
          {
            Name       = "${var.environment_tag}-NAT-GW-0"
            environment = var.environment_tag
          },
            var.network_additional_tags
          )
}


# Creation of Public route table having route to IGW
resource "aws_route_table" "rtb_public_A" {
  vpc_id = aws_vpc.vpc.id
  tags = merge(
          {
            Name       = "${var.environment_tag}-public-route-table"
            environment = var.environment_tag
          },
            var.network_additional_tags
          )
}

resource "aws_route" "rtb_public" {
  route_table_id            = aws_route_table.rtb_public_A.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw.id
}

# Creation of Private route table having route to NATs
resource "aws_route_table" "rtb_private_A" {
  vpc_id = aws_vpc.vpc.id
  tags = merge(
          {
            Name       = "${var.environment_tag}-private-route-table"
            environment = var.environment_tag
          },
            var.network_additional_tags
          )
}

resource "aws_route" "rtb_private_A" {
  route_table_id            = aws_route_table.rtb_private_A.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.ngwA.id
}

resource "aws_route_table_association" "rta_subnet_public" {
  for_each = var.public_subnets_cidr
  subnet_id      = aws_subnet.subnet_public[each.key].id
  route_table_id = aws_route_table.rtb_public.id
}

resource "aws_route_table_association" "rta_subnet_private" {
  for_each = var.private_subnets_cidr
  subnet_id      = aws_subnet.subnet_private[each.key].id
  route_table_id = aws_route_table.rtb_private.id
}


