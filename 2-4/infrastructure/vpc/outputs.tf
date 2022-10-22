output "vpc_id" {
	value = aws_vpc.vpc.id
}

output "public_subnets_0" {
	value = aws_subnet.subnet_public[0].id
}

output "private_subnets_0" {
	value = aws_subnet.subnet_private[0].id
}

output "public_subnets_1" {
	value = aws_subnet.subnet_public[1].id
}

output "private_subnets_1" {
	value = aws_subnet.subnet_private[1].id
}
