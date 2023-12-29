terraform {
  required_version = ">= 1.5.5"
  required_providers {
    proxmox = {
      source  = "TheGameProfi/proxmox"
      version = "2.9.15"
    }
  }
}
