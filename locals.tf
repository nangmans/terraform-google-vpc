locals {
  module_name    = "terraform-google-vpc"
  module_version = "v0.0.1"

  peer_networks = (
    var.peering_config == null ? null :
    element(reverse(split("/", var.peering_config.peer_vpc_self_link)), 0)
  )
}