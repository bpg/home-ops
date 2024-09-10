terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
    }
  }
}

resource "proxmox_virtual_environment_vm" "fileserver" {
  name      = local.hostname
  node_name = var.target_node

  tags = ["infra", "network"]

  migrate = true

  agent {
    enabled = true
  }

  cpu {
    cores = 2
  }

  memory {
    dedicated = 1024
  }

  disk {
    datastore_id = "tank"
    file_id      = "cephfs:iso/jammy-server-cloudimg-amd64.img"
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = 128
  }

  initialization {
    datastore_id = "tank"
    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }
    user_data_file_id = proxmox_virtual_environment_file.cloud_config.id
  }

  lifecycle {
    ignore_changes = [
      initialization,
    ]
  }

  smbios {
    serial = "ds=nocloud-net;h=${local.hostname}"
  }

  network_device {
    bridge = "vmbr016"
  }
}
