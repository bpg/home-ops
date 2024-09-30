terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = ">= 0.63"
    }
    talos = {
      source  = "siderolabs/talos"
      version = "0.5.0"
    }
  }
}

provider "proxmox" {
  endpoint  = var.virtual_environment_endpoint
  api_token = var.virtual_environment_api_token
  insecure  = false
}


provider "proxmox" {
  alias     = "ssh"
  endpoint  = var.virtual_environment_endpoint
  api_token = var.virtual_environment_api_token
  insecure  = false
  ssh {
    agent    = true
    username = var.virtual_environment_ssh_username
    node {
      name    = "pve1"
      address = "10.99.0.81"
    }
    node {
      name    = "pve2"
      address = "10.99.0.82"
    }
    node {
      name    = "pve3"
      address = "10.99.0.83"
    }
  }
  #…
}
