output "network" {
  value       = module.vpc-local.network
  description = "The VPC resource being created"
}

output "network_name" {
  value       = module.vpc-local.network_name
  description = "The name of the VPC being created"
}

output "network_id" {
  value       = module.vpc-local.network_id
  description = "The ID of the VPC being created"
}

output "network_self_link" {
  value       = module.vpc-local.network_self_link
  description = "The URI of the VPC being created"
}

output "project_id" {
  value       = module.vpc-local.project_id
  description = "VPC project id"
}
