variable "template_node" {
  description = "Hostname of the Proxmox node where template VMs are stored"
  type        = string
}

variable "node_vlan_interfaces" {
  type = map(string)
}

variable "vlans" {
  description = "Map of VLAN objects indexed on name"
  type = list(object({
    vlan_id = number,
    comment = string
    ipv4_gateway = string,
    ipv4_dns_servers = list(string)
  }))
}

variable "vm_templates" {
  description = "Map of VM template objects keyed on template name"
  type = map(object({
    vm_id            = number,
    cloud_init_image = string,
    vlan             = number
  }))
}

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

#=========================
# cloud-init image files
#=========================
variable "cloud_init_images" {
  type = map(object({
    url       = string,
    file_name = string
  }))
}

#=========================
# cloud-init image files
#=========================
variable "iso_storage" {
  type = object({
    node = string,
    name = string
  })
}
