locals {
  k8s_vlan = var.vlans[index(var.vlans.*.comment, "DMZ")]
}

resource "proxmox_virtual_environment_vm" "k8s_control_plane" {
  depends_on  = [proxmox_virtual_environment_vm.vm_templates]
  for_each    = { for n in var.control_plane_nodes:
                    n.hostname => {
                      pve_node = n.pve_node,
                      vm_id = n.vm_id,
                      cloud_init_image = n.cloud_init_image,
                      mac_address = n.mac_address,
                      ipv4_address = n.ipv4_address
                    }
                }
  name        = each.key
  description = "Managed by Terraform"
  tags        = [each.value.cloud_init_image, "k8s", "terraform"]
  node_name   = each.value.pve_node
  vm_id       = each.value.vm_id

  clone {
    datastore_id = "truenas1"
    node_name    = "pve3"
    vm_id        = var.vm_templates[each.value.cloud_init_image].vm_id
    full         = true
  }
  disk {
    datastore_id = "truenas1"
    interface    = "scsi0"
    size         = 60
    discard      = "on"
    iothread     = true
    ssd          = true
  }
  initialization {
    datastore_id = "truenas1"
    dns {
      servers = local.k8s_vlan.ipv4_dns_servers
    }
    ip_config {
      ipv4 {
        address = each.value.ipv4_address
        gateway = local.k8s_vlan.ipv4_gateway
      }
    }
    user_account {
      username = var.ciuser
      password = var.cipassword
      keys     = var.cipubkey
    }
  }
  memory {
    dedicated = 8192
    floating  = 8192
  }
  network_device {
    bridge      = "vmbr0"
    mac_address = each.value.mac_address
    vlan_id     = local.k8s_vlan.vlan_id
  }
  on_boot = true
  connection {
    type     = "ssh"
    user     = var.ciuser
    agent    = true
    host     = self.name
  }
  provisioner "remote-exec" {
    inline = [ "ip a" ]
  }
  vga {
    type = "qxl"
  }
}

resource "proxmox_virtual_environment_vm" "k8s_workers" {
  depends_on  = [proxmox_virtual_environment_vm.vm_templates]
  for_each    = { for n in var.worker_nodes:
                    n.hostname => {
                      pve_node = n.pve_node,
                      vm_id = n.vm_id,
                      cloud_init_image = n.cloud_init_image,
                      mac_address = n.mac_address,
                      ipv4_address = n.ipv4_address
                    }
                }
  name        = each.key
  description = "Managed by Terraform"
  tags        = [each.value.cloud_init_image, "k8s", "terraform"]
  node_name   = each.value.pve_node
  vm_id       = each.value.vm_id

  clone {
    datastore_id = "truenas1"
    node_name    = "pve3"
    vm_id        = var.vm_templates[each.value.cloud_init_image].vm_id
    full         = true
  }
  disk {
    datastore_id = "truenas1"
    interface    = "scsi0"
    size         = 60
    discard      = "on"
    iothread     = true
    ssd          = true
  }
  initialization {
    datastore_id = "truenas1"
    dns {
      servers = local.k8s_vlan.ipv4_dns_servers
    }
    ip_config {
      ipv4 {
        address = each.value.ipv4_address
        gateway = local.k8s_vlan.ipv4_gateway
      }
    }
    user_account {
      username = var.ciuser
      password = var.cipassword
      keys     = var.cipubkey
    }
  }
  memory {
    dedicated = 8192
    floating  = 8192
  }
  network_device {
    bridge      = "vmbr0"
    mac_address = each.value.mac_address
    vlan_id     = local.k8s_vlan.vlan_id
  }
  on_boot = true
  connection {
    type     = "ssh"
    user     = var.ciuser
    agent    = true
    host     = self.name
  }
  provisioner "remote-exec" {
    inline = [ "ip a" ]
  }
  vga {
    type = "qxl"
  }
}
