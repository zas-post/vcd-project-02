
# --------------------------------------------------------------------------------------------------
# CloudFormation Network Layer: VPC, Subnets + RouteTables, Internet + NAT Gateways
# Author: Alexander
#
# Version      Date           Name                Info
# 1.0          28-Feb-2020    Alexander           Initial Version
#
# --------------------------------------------------------------------------------------------------


# Creating vApp
resource "vcd_vapp" "tf_vapp" {
  name        = var.vapp_name
  description = var.vapp_description
  org         = var.vcd_org
  vdc         = var.vcd_vdc
  power_on    = true

  metadata_entry {}
}

# Creating vAPP network
resource "vcd_vapp_network" "vappNet" {
  #org           = var.vcd_org
  #vdc           = var.vcd_vdc
  name          = "vapp-netw-${var.vapp_ip_netw}/${var.vapp_ip_prefix_24}"
  vapp_name     = vcd_vapp.tf_vapp.name
  gateway       = var.vapp_ip_gw
  prefix_length = var.vapp_ip_prefix_24
  description   = "vapp-netw-${var.vapp_ip_netw}/${var.vapp_ip_prefix_24}"

  static_ip_pool {
    start_address = "${var.vapp_ip_netw}.100"
    end_address   = "${var.vapp_ip_netw}.255"
  }
}

# Creating Catalog
resource "vcd_catalog" "mycatalog" {
  org = var.vcd_org

  name             = var.vcd_catalog
  description      = "Catalog created by Terraform"
  delete_recursive = "true"
  delete_force     = "true"
}

# Uploading an OVA to a Catalog
resource "vcd_catalog_item" "ubuntu-2110-cloud" {
  org     = vcd_catalog.mycatalog.org
  catalog = vcd_catalog.mycatalog.name

  name                 = var.template_vm
  description          = "Ubuntu 22.04 cloud image"
  ova_path             = "${var.ova_path}jammy-server-cloudimg-amd64.ova"
  upload_piece_size    = 10
}


### Data sources of catalog ###
data "vcd_catalog" "my-catalog" {
  org  = var.vcd_org
  name = var.vcd_catalog
}

data "vcd_catalog_vapp_template" "template_vm" {
  org        = var.vcd_org
  catalog_id = data.vcd_catalog.my-catalog.id
  name       = var.template_vm
}


# # Uploading an VM to vAPP
# Creating the VM in the vApp
resource "vcd_vapp_vm" "ubuntu" {
  vapp_name        = vcd_vapp.tf_vapp.name
  name             = "ubuntu-01"
  computer_name    = "ubuntu-01"
  description      = var.template_vm

  hardware_version = "vmx-14"
  power_on         = true

  cpus = 2
  memory = 2048

  os_type          = var.os_type_ubuntu_x64
  vapp_template_id = data.vcd_catalog_vapp_template.template_vm.id


  # Map the network from the data source to the VM
  network {
    name               = vcd_vapp_network.vappNet.name
    adapter_type       = "VMXNET3"
    type               = "none"
    # ip = vc
    ip                 = "${var.vapp_ip_netw}.101"
    ip_allocation_mode = "MANUAL"
    is_primary         = true
  }

  guest_properties = {
    "instance-id" = var.template_vm
    "hostname"    = var.template_vm
  }
}
