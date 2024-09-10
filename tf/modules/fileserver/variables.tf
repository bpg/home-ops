variable "target_node" {
  description = "The target node to deploy the fileserver"
  type        = string
}

variable "ssh_public_key" {
  description = "The public key to use for the fileserver"
  type        = string
}
