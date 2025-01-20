output "vpc_id" {
  value = module.prism_mw_vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.prism_mw_vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.prism_mw_vpc.private_subnet_ids
}
