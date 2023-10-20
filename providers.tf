terraform {
  required_providers {
    vcd = {
      source = "vmware/vcd"
      version = "3.10.0"
    }
  }
}


# Configuration options
provider "vcd" {
  user                 = var.vcd_user
  password             = var.vcd_password
  auth_type            = "integrated"
  org                  = var.vcd_org
  vdc                  = var.vcd_vdc
  url                  = "${var.vcd_url}/api"
  max_retry_timeout    = var.vcd_max_retry_timeout
  # allow_unverified_ssl = var.vcd_allow_unverified_ssl
}
