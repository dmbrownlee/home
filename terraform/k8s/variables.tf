variable "control_plane_nodes" {
  type = list(object({
    hostname = string,
    pve_node = string,
    vm_id    = number,
    mac_address = string
  }))
}

variable "worker_nodes" {
  type = list(object({
    hostname = string,
    pve_node = string,
    vm_id    = number,
    mac_address = string
  }))
}

#===========================================================
# These variables are used by the Terraform Proxmox provider
#
# Rather than editng the default values here, you can
# override them in terraform.tfvars
#===========================================================
variable "api_token" {
  description = "Proxmox API token"
  type        = string
}

variable "endpoint" {
  description = "URL of the Proxmox cluster API"
  type        = string
  default     = "https://pve1.example.com:8006/"
}

variable "ciuser" {
  description = "Default cloud-init account"
  type        = string
  default     = "ansible"
}

variable "cipassword" {
  description = "Password for cloud-init account"
  type        = string
  sensitive   = true
}

variable "cipubkey" {
  description = "Cloud-init public key"
  type        = list(string)
}

variable "ssh_private_key_files" {
  description = "A map of SSH private key paths"
  type        = map(string)
}

