resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = merge(var.tags, { Name = "${var.name}-vpc" })
}

resource "aws_flow_log" "vpc" {
  vpc_id = aws_vpc.this.id
  traffic_type = "ALL"
  log_destination_type = "cloud-watch-logs"
  log_group_name = "/aws/vpc/flowlogs/${var.name}"
  iam_role_arn = aws_iam_role.vpc_flow_logs.arn
}

resource "aws_iam_role" "vpc_flow_logs" {
  name = "${var.name}-vpc-flow-logs-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "vpc-flow-logs.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "vpc_flow_logs" {
  role       = aws_iam_role.vpc_flow_logs.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonAPIGatewayPushToCloudWatchLogs"
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = merge(var.tags, { Name = "${var.name}-igw" })
}

resource "aws_subnet" "public" {
  count = 2
  vpc_id = aws_vpc.this.id
  cidr_block = var.public_subnet_cidrs[count.index]
  availability_zone = var.azs[count.index]
  map_public_ip_on_launch = true
  tags = merge(var.tags, { Name = "${var.name}-public-${var.azs[count.index]}" })
}

resource "aws_subnet" "private" {
  count = 2
  vpc_id = aws_vpc.this.id
  cidr_block = var.private_subnet_cidrs[count.index]
  availability_zone = var.azs[count.index]
  map_public_ip_on_launch = false
  tags = merge(var.tags, { Name = "${var.name}-private-${var.azs[count.index]}" })
}

resource "aws_subnet" "isolated" {
  count = 2
  vpc_id = aws_vpc.this.id
  cidr_block = var.isolated_subnet_cidrs[count.index]
  availability_zone = var.azs[count.index]
  map_public_ip_on_launch = false
  tags = merge(var.tags, { Name = "${var.name}-isolated-${var.azs[count.index]}" })
}

resource "aws_nat_gateway" "this" {
  count = 2
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id
  tags = merge(var.tags, { Name = "${var.name}-nat-${var.azs[count.index]}" })
}

resource "aws_eip" "nat" {
  count = 2
  tags = merge(var.tags, { Name = "${var.name}-eip-${var.azs[count.index]}" })
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
  tags = merge(var.tags, { Name = "${var.name}-public-rt" })
}

resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

resource "aws_route_table_association" "public" {
  count = 2
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  count = 2
  vpc_id = aws_vpc.this.id
  tags = merge(var.tags, { Name = "${var.name}-private-rt-${var.azs[count.index]}" })
}

resource "aws_route" "private_nat_gateway" {
  count = 2
  route_table_id         = aws_route_table.private[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.this[count.index].id
}

resource "aws_route_table_association" "private" {
  count = 2
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}

resource "aws_route_table" "isolated" {
  count = 2
  vpc_id = aws_vpc.this.id
  tags = merge(var.tags, { Name = "${var.name}-isolated-rt-${var.azs[count.index]}" })
}

resource "aws_route_table_association" "isolated" {
  count = 2
  subnet_id      = aws_subnet.isolated[count.index].id
  route_table_id = aws_route_table.isolated[count.index].id
} 