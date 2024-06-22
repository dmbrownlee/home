###############################################################################
###############################################################################
##
##  Variables
##
###############################################################################
###############################################################################
variable "site_domain" {
  description = "The DNS domain (used in cloud-init data when creating VMs)"
  type        = string
  default     = "example.com"
}

variable "vms" {
  description = "The list of Proxmox VMs"
  type = list(object({
    vm_id            = number,
    hostname         = string,
    role             = string,
    pve_node         = string,
    cloud_init_image = string,
    hardware = object({
      cpu_cores = number,
      memory    = number,
      disk      = number
    })
    mac_address  = string,
    vlan_id      = number,
    ipv4_address = string
  }))
}

variable "vm_storage" {
  description = "Name of Proxmox storage location where VM disks are stored"
  type        = string
}

variable "vm_template_storage" {
  description = "Proxmox node and storage name where VM templates are stored"
  type = object({
    node = string,
    name = string
  })
}

###############################################################################
###############################################################################
##
##  Cloud-init
##
###############################################################################
###############################################################################
variable "ci_user" {
  description = "Default cloud-init account"
  type        = string
}

variable "ci_password" {
  description = "Password for cloud-init account"
  type        = string
  sensitive   = true
}

###############################################################################
###############################################################################
##
##  Ansible
##
###############################################################################
###############################################################################
variable "ansible_replayable" {
  description = "Flag whether or not Ansible playbooks can be run again."
  type        = bool
  default     = true
}

variable "sleep_seconds_before_remote_provisioning" {
  description = "The number of seconds to wait after booting before trying SSH"
  type        = number
}

variable "ssh_private_key_files" {
  description = "A map of SSH private key paths"
  type        = map(string)
}

###############################################################################
###############################################################################
##
##  Control host
##
###############################################################################
###############################################################################
variable "ssh_keystore" {
  description = "Local path to directory of SSH keys"
  type        = string
}


###############################################################################
###############################################################################
##
##  Flags for development and testing
##
###############################################################################
###############################################################################
variable "want_ansible_output" {
  type    = bool
  default = false
}

###############################################################################
###############################################################################
##
##  Resources
##
###############################################################################
###############################################################################
resource "proxmox_virtual_environment_vm" "devclients" {
  depends_on = [
    proxmox_virtual_environment_network_linux_vlan.vlans,
    data.proxmox_virtual_environment_vms.cloud_init_template
  ]
  for_each    = { for vm in var.vms : vm.hostname => vm if vm.role == "devclient" }
  name        = each.key
  description = "Managed by Terraform"
  tags        = ["terraform", each.value.cloud_init_image, each.value.role]
  node_name   = each.value.pve_node
  vm_id       = each.value.vm_id

  clone {
    datastore_id = var.vm_template_storage.name
    node_name    = var.vm_template_storage.node
    vm_id        = data.proxmox_virtual_environment_vms.cloud_init_template.vms[index(data.proxmox_virtual_environment_vms.cloud_init_template.vms[*].name, each.value.cloud_init_image)].vm_id
    full         = true
  }
  cpu {
    sockets = 1
    cores   = each.value.hardware.cpu_cores
    type    = "x86-64-v2-AES"
  }
  disk {
    datastore_id = var.vm_storage
    interface    = "scsi0"
    size         = each.value.hardware.disk
    discard      = "on"
    iothread     = true
    ssd          = true
  }
  initialization {
    datastore_id = var.vm_storage
    dns {
      servers = var.vlans[index(var.vlans.*.vlan_id, each.value.vlan_id)].ipv4_dns_servers
      domain  = var.site_domain
    }
    ip_config {
      ipv4 {
        address = each.value.ipv4_address
        gateway = var.vlans[index(var.vlans.*.vlan_id, each.value.vlan_id)].ipv4_gateway
      }
    }
    #upgrade = false
    user_account {
      username = var.ci_user
      password = var.ci_password
      keys     = [trimspace(data.local_file.ci_ssh_public_key_file.content)]
    }
  }
  memory {
    dedicated = each.value.hardware.memory
    floating  = each.value.hardware.memory
  }
  network_device {
    bridge      = "vmbr0"
    mac_address = each.value.mac_address
    vlan_id     = each.value.vlan_id
  }
  on_boot = true
  connection {
    type  = "ssh"
    user  = var.ci_user
    agent = true
    host  = "${self.name}.${var.site_domain}"
  }
  provisioner "local-exec" {
    command = "sleep ${var.sleep_seconds_before_remote_provisioning}"
  }
  provisioner "remote-exec" {
    inline = ["hostnamectl"]
  }
  vga {
    type = "qxl"
  }
}
