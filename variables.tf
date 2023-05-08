variable "project_id" {
  description = "The ID of the project in which the resource belongs."
  type        = string
}

variable "impersonate_sa" {
  description = "Email of the service account to use for Terraform"
  type        = string
}

variable "validate_labels" {
  description = "validate labels"
  type        = map(string)
}

variable "network_name" {
  description = "The name of the network being created"
  type = string
}

variable "routing_mode" {
  description = "The network routing mode (default 'GLOBAL')"
  type        = string
  default     = "GLOBAL"
}

variable "shared_vpc_host" {
  description = "Makes this project a Shared VPC host if 'true' (default 'false')"
  type        = bool
  default     = false
}

variable "shared_vpc_service_projects" {
  description = "value"
  type        = list(string)
  default     = []
}

variable "description" {
  description = "An optional description of this resource. The resource must be recreated to modify this field."
  type        = string
  default     = ""
}

variable "auto_create_subnetworks" {
  description = "When set to true, the network is created in 'auto subnet mode' and it will create a subnet for each region automatically across the 10.128.0.0/9 address range. When set to false, the network is created in 'custom subnet mode' so the user can explicitly connect subnetwork resources."
  type        = bool
  default     = false
}

variable "delete_default_internet_gateway_routes" {
  description = "If set, ensure that all routes within the network specified whose names begin with 'default-route' and with a next hop of 'default-internet-gateway' are deleted"
  type        = bool
  default     = false
}

variable "mtu" {
  description = "The network MTU (If set to 0, meaning MTU is unset - defaults to '1460'). Recommended values: 1460 (default for historic reasons), 1500 (Internet default), or 8896 (for Jumbo packets). Allowed are all values in the range 1300 to 8896, inclusively."
  type        = number
  default     = 1460
}

variable "enable_ula_internal_ipv6" {
  description = "Enable ULA internal ipv6 on this network. Enabling this feature will assign a /48 from google defined ULA prefix fd20::/20."
  type        = bool
  default     = false
}

variable "internal_ipv6_range" {
  description = "When enabling ula internal ipv6, caller optionally can specify the /48 range they want from the google defined ULA prefix fd20::/20"
  type        = string
  default     = ""
}

variable "peering_config" {
  description = "VPC Peering configurations"
  type = object({
    peer_vpc_self_link = string
    create_remote_peer = optional(bool, true)
    export_routes      = optional(bool)
    import_routes      = optional(bool)
  })
  default = null
}