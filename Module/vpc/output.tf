output "vpc_id" {
  value = aws_vpc.prismvpc.id
  description = "ID of the VPC"
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
  description = "IDs of the public subnets"
}

output "private_subnet_ids" {
  value = aws_subnet.private[*].id
  description = "IDs of the private subnets"
}

output "internet_gateway_id" {
  value = aws_internet_gateway.prismvpcgw.id
  description = "ID of the Internet Gateway"
}

output "public_route_table_id" {
  value = aws_route_table.public.id
  description = "ID of the public route table"
}

output "private_route_table_id" {
  value = aws_route_table.private.id
  description = "ID of the private route table"
}