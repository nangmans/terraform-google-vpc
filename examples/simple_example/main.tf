module "vpc-local" {
  source = "../.."

  project_id   = var.project_id
  network_name = "vpc-fin-prod-network-hub"
  description = var.description
  region = var.region
  
  routing_mode = var.routing_mode
  auto_create_subnetworks = var.auto_create_subnetworks
  delete_default_internet_gateway_routes = var.delete_default_internet_gateway_routes
  mtu = var.mtu

  shared_vpc_host = true
  shared_vpc_service_projects = var.shared_vpc_service_projects
  
  enable_ula_internal_ipv6 = var.enable_ula_internal_ipv6
  internal_ipv6_range = var.internal_ipv6_range

  #peering_config = var.peering_config

}

resource "google_compute_route" "default" {
  name        = "network-route"
  dest_range  = "15.0.0.0/24"
  network     = module.vpc-local.network_id
  next_hop_ip = "10.132.1.5"
  priority    = 100
}
# module "vpc-peer" {
#   source = "../.."

#   project_id   = var.project_id
#   network_name = var.network_name
#   description = var.description

#   routing_mode = var.routing_mode
#   auto_create_subnetworks = var.auto_create_subnetworks
#   delete_default_internet_gateway_routes = var.delete_default_internet_gateway_routes
#   mtu = var.mtu
  
#   enable_ula_internal_ipv6 = var.enable_ula_internal_ipv6
#   internal_ipv6_range = var.internal_ipv6_range

# }



