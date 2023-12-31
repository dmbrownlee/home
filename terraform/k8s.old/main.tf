terraform {
  required_version = "~> 1.6.1"
  required_providers {
    proxmox = {
      source  = "TheGameProfi/proxmox"
      version = "2.9.15"
    }
  }
}
