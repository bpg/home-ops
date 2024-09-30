data "local_file" "ssh_public_key" {
  filename = "id_rsa.pub"
}

locals {
  ssh_public_key = trimspace(data.local_file.ssh_public_key.content)
}

module "fileserver" {
  providers = {
    proxmox = proxmox.ssh
  }

  source         = "./modules/fileserver"
  target_node    = "pve2"
  ssh_public_key = local.ssh_public_key
}

module "k8s-prod" {
  providers = {
    proxmox = proxmox.ssh
  }

  source      = "./modules/k8s-prod"
  # target_node = "pve1"
}

# module "test" {
#   providers = {
#     proxmox = proxmox.ssh
#   }

#   source = "./modules/test"
#   target_node    = "pve1"
# }


output "fileserver_ip_address" {
  value = module.fileserver.ip_address
}
