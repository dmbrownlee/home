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

#===========================================================
# These variables are specific to the deployment
#===========================================================
variable "server_count" {
  description = "The number of k3s servers"
  type        = number
}

variable "agent_count" {
  description = "The number of k3s agents"
  type        = number
}

#===========================================================
# These variables are specific to cloud-init
#===========================================================
variable "ciuser" {
  description = "Configuration management account"
  type        = string
}

variable "cipassword" {
  description = "Configuration management account password"
  type        = string
}

variable "cloud_image" {
  description = "The name of the cloud image to clone"
  type        = string
  default     = "debian12-cloud"
}

variable "target_node" {
  description = "The node on which to create the clone"
  type        = string
}

variable "storage" {
  description = "The storage pool on which to create the disks"
  type        = string
}

variable "first_ip" {
  description = "Starting host number"
  type        = number
}

variable "network" {
  description = "Network address and CIDR prefix"
  type        = string
}

variable "gateway" {
  description = "IPv4 address of the default gateway"
  type        = string
}

variable "searchdomain" {
  description = "The local DNS domain"
  type        = string
}

variable "nameserver" {
  description = "IPv4 address of the local nameserver"
  type        = string
}

variable "vlan" {
  description = "The VLAN ID on the primary network interface"
  type        = number
}

variable "cores" {
  description = "Number of CPU cores per socket"
  type        = number
}

variable "memory" {
  description = "Amount of RAM memory (in MB) installed in the VM"
  type        = number
}
