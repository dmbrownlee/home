terraform {
  required_version = "~> 1.7.1"
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.43.2"
    }
  }
}

provider "proxmox" {
  api_token = var.api_token
  endpoint  = var.endpoint
  insecure  = true
  ssh {
    agent    = true
    username = "root"
  }
}
