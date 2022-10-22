output "vpc_id" {
	value = aws_vpc.vpc.id
}

output "public_subnets" {
	value = aws_subnet.subnet_public[*]
}

output "public_subnets_ids" {
	value = values(aws_subnet.subnet_public)[*].id
}

output "eks_private_subnets" {
	value = aws_subnet.eks_subnet_private[*]
}

output "eks_private_subnets_ids" {
	value = values(aws_subnet.eks_subnet_private)[*].id
}
