locals {
  common_tags = merge(
    {
      Name      = var.name
      ManagedBy = "Terraform"
    },
    var.tags,
  )
}

resource "aws_vpc_peering_connection" "this" {
  vpc_id      = var.requester_vpc_id
  peer_vpc_id = var.accepter_vpc_id
  auto_accept = var.auto_accept

  requester {
    allow_remote_vpc_dns_resolution = true
  }

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  tags = local.common_tags
}

# Fix: Chuyển from toset() to map với static keys
resource "aws_route" "requester_to_accepter" {
  for_each = {
    for idx, rt_id in var.requester_route_table_ids : "route_${idx}" => rt_id
  }

  route_table_id            = each.value
  destination_cidr_block    = var.accepter_vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.this.id
}

resource "aws_route" "accepter_to_requester" {
  for_each = {
    for idx, rt_id in var.accepter_route_table_ids : "route_${idx}" => rt_id
  }

  route_table_id            = each.value
  destination_cidr_block    = var.requester_vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.this.id

  depends_on = [aws_vpc_peering_connection.this]
}
