output "ip_address" {
  value = proxmox_virtual_environment_vm.fileserver.ipv4_addresses[1][0]
}
