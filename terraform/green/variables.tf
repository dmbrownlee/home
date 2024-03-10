#===========================================================
# These variables are used by the Terraform Proxmox provider
#===========================================================
variable "pm_api_url" {
  description = "URL of the Proxmox cluster API"
  type        = string
}

variable "pm_api_token_secret" {
  description = "Proxmox API token secret"
  type        = string
}

variable "pm_api_token_id" {
  description = "Proxmox API token ID"
  type        = string
}

variable "green_target_node" {
  description = "Proxmox node for Green nodes"
  type        = string
}
