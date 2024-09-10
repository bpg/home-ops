terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
    }
  }
}

resource "proxmox_virtual_environment_file" "test_snippet" {
  content_type = "snippets"
  datastore_id = "cephfs"
  node_name    = var.target_node

  source_raw {
    data = <<-EOF
    test
    EOF

    file_name = "test.txt"
  }
}
