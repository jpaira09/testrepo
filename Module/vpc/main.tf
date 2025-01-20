# Fetch Availability Zones
data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "prismvpc" {
  cidr_block           = var.vpc_map.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = merge(var.tags, { Name = "${var.vpc_name}" }) 
}

resource "aws_internet_gateway" "prismvpcgw" {
  vpc_id = aws_vpc.prismvpc.id
  tags = merge(var.tags, { Name = "${var.vpc_name}-igw" })
}

# Create Public Subnets
resource "aws_subnet" "public" {
  count = length(var.vpc_map.public_subnet_cidrs)
  
  vpc_id                  = aws_vpc.prismvpc.id
  cidr_block              = var.vpc_map.public_subnet_cidrs[count.index]
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags                    = merge(var.tags, { Name = "${var.vpc_name}-public-subnet-${count.index + 1}" })
}

# Create Private Subnets
resource "aws_subnet" "private" {
  count = length(var.vpc_map.private_subnet_cidrs)
  
  vpc_id                  = aws_vpc.prismvpc.id
  cidr_block              = var.vpc_map.private_subnet_cidrs[count.index]
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  tags                    = merge(var.tags, { Name = "${var.vpc_name}-private-subnet-${count.index + 1}" })
}

# Create Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.prismvpc.id
  tags   = merge(var.tags, { Name = "${var.vpc_name}-public-route-table" })
}

# Create Route in Public Route Table
resource "aws_route" "public_internet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.prismvpcgw.id
}

# Associate Public Subnets with Public Route Table
resource "aws_route_table_association" "public" {
  count = length(var.vpc_map.public_subnet_cidrs)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# Create Private Route Table 
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.prismvpc.id
  tags   = merge(var.tags, { Name = "${var.vpc_name}-private-route-table" })
}


# Associate Private Subnets with Private Route Table
resource "aws_route_table_association" "private" {
  count = length(var.vpc_map.private_subnet_cidrs)

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}