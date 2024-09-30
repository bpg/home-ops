locals {
  talos = {
    version = "v1.8.0"
  }
}

resource "proxmox_virtual_environment_download_file" "talos_nocloud_image" {
  /*
  The talos immage has been customized using https://factory.talos.dev/ and the following:
    customization:
      systemExtensions:
          officialExtensions:
              - siderolabs/iscsi-tools
              - siderolabs/qemu-guest-agent
              - siderolabs/tailscale
  */
  content_type            = "iso"
  datastore_id            = "cephfs"
  node_name               = "pve1"
  file_name               = "talos-${local.talos.version}-nocloud-amd64.img"
  url                     = "https://factory.talos.dev/image/58e4656b31857557c8bad0585e1b2ee53f7446f4218f3fae486aa26d4f6470d8/${local.talos.version}/nocloud-amd64.raw.xz"
  overwrite               = false
}
