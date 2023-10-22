terraform {
  required_version = "~> 1.6.1"
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "2.9.14"
    }
    ansible = {
      source  = "ansible/ansible"
      version = "1.1.0"
    }
  }
}
