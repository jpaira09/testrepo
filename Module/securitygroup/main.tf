# Create Security Group
resource "aws_security_group" "prsm_sg" {
  description = "Allow inbound traffic on multiple ports and all outbound traffic"
  vpc_id      = var.vpc_id
  tags = merge(var.tags, { Name = "${var.sg_name}" })
}

# Create ingress rules for allowed ports
resource "aws_vpc_security_group_ingress_rule" "prsm_sg_ingress" {
  count = length(var.allowed_ports)

  security_group_id = aws_security_group.prsm_sg.id
  cidr_ipv4         = var.ipv4_range
  from_port         = var.allowed_ports[count.index]
  ip_protocol       = "tcp"
  to_port           = var.allowed_ports[count.index]
}

# Create egress rules for all traffic
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.prsm_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6" {
  security_group_id = aws_security_group.prsm_sg.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1"
}