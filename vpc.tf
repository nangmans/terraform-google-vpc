resource "google_compute_network" "network" {
  name                            = var.network_name
  auto_create_subnetworks         = var.auto_create_subnetworks
  routing_mode                    = var.routing_mode
  project                         = var.project_id
  description                     = var.description
  delete_default_routes_on_create = var.delete_default_internet_gateway_routes
  mtu                             = var.mtu
  enable_ula_internal_ipv6        = var.enable_ula_internal_ipv6
  internal_ipv6_range             = var.internal_ipv6_range
}

resource "google_compute_shared_vpc_host_project" "shared_vpc_host" {

  count      = var.shared_vpc_host ? 1 : 0
  project    = var.project_id
  depends_on = [google_compute_network.network]
}

resource "google_compute_shared_vpc_service_project" "service_project" {

  for_each = toset(
    var.shared_vpc_host && var.shared_vpc_service_projects != null
    ? var.shared_vpc_service_projects : []
  )
  host_project    = var.project_id
  service_project = each.value

  depends_on = [
    google_compute_shared_vpc_host_project.shared_vpc_host
  ]
}

resource "google_compute_network_peering" "local" {
  count                = var.peering_config == null ? 0 : 1
  name                 = "vpcpeer-${var.network_name}-${local.peer_networks}"
  network              = google_compute_network.network.self_link
  peer_network         = var.peering_config.peer_vpc_self_link
  export_custom_routes = var.peering_config.export_routes
  import_custom_routes = var.peering_config.import_routes
}

resource "google_compute_network_peering" "remote" {
  count = (var.peering_config != null && try(var.peering_config.create_remote_peer, true)
    ? 1 : 0
  )
  name                 = "vpcpeer-${local.peer_networks}-${var.network_name}"
  network              = var.peering_config.peer_vpc_self_link
  peer_network         = google_compute_network.network.self_link
  export_custom_routes = var.peering_config.export_routes
  import_custom_routes = var.peering_config.import_routes

  depends_on = [
    google_compute_network_peering.local
  ]
}