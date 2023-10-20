#Output of the created vAPP
output "name" {
  value = resource.vcd_vapp.tf_vapp.name
}

output "id" {
  value = resource.vcd_vapp.tf_vapp.id
}

output "status_text" {
  value = resource.vcd_vapp.tf_vapp.status_text
}

output "status" {
  value = resource.vcd_vapp.tf_vapp.status
}

output "href" {
  value = resource.vcd_vapp.tf_vapp.href
}

output "ubuntu_password" {
  value = nonsensitive(resource.vcd_vapp_vm.ubuntu.customization[0].admin_password)
  #sensitive = true
}
