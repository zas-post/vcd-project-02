# ------------------------------------------------
# Provider config
# ------------------------------------------------

variable "vcd_user" {
  default     = "administrator"
  description = "vCD Tenant User"
  type        = string
}

variable "vcd_password" {
  default     = "password"
  description = "vCD Tenant Password"
  type        = string
  sensitive   = true
}

variable "vcd_org" {
  default     = "def_org_vdc"
  description = "vCD Tenant Org"
}

variable "vcd_vdc" {
  default     = "def_org_vdc"
  description = "vCD Tenant VDC"
}

variable "vcd_url" {
  default     = "def_url_vdc"
  description = "vCD Tenant URL"
}

variable "vcd_max_retry_timeout" {
  description = "Retry Timeout"
  default     = "240"
}

variable "vcd_allow_unverified_ssl" {
  description = "vCD allow unverified SSL"
  default     = "true"
}


# ------------------------------------------------
# Create vAPP
# ------------------------------------------------

variable "vapp_name" {
  description = "vCD vAPP Name"
}

variable "vapp_description" {
  description = "vCD vAPP Description"
}


variable "vcd_edge_name" {
  description = "vCD edge name"
  default     = "def_edge"
}

variable "vcd_catalog" {
  description = "vCD Catalog Name"
}

variable "template_vm" {
  description = "template vm"
}

variable "ova_path" {
  description = "ova_path"
}

variable "os_type_ubuntu_x64" {
  description = "os_type_ubuntu_x64"
}

variable "vapp_ip_netw" {
  description = "vCD vAPP Netw"
  #default = "def_vapp_ip_netw"
}

variable "vapp_ip_gw" {
  description = "vCD vAPP Gateway"
  #default = "vapp_ip_gw"
}

variable "vapp_ip_prefix_24" {
  description = "vCD vAPP Mask Prefix Length"
}