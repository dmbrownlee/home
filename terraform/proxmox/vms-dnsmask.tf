locals {
  dnsmask_vlan = var.vlans[index(var.vlans.*.comment, "DMZ")]
}

resource "proxmox_virtual_environment_vm" "dnsmask" {
  depends_on  = [proxmox_virtual_environment_vm.vm_templates]
  for_each    = { for n in var.dnsmask_nodes:
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
  tags        = [each.value.cloud_init_image, "dnsmask", "terraform"]
  node_name   = each.value.pve_node
  vm_id       = each.value.vm_id

  clone {
    datastore_id = var.vm_template_storage.name
    node_name    = var.vm_template_storage.node
    vm_id        = var.vm_templates[each.value.cloud_init_image].vm_id
    full         = true
  }
  disk {
    datastore_id = var.vm_storage
    interface    = "scsi0"
    size         = 20
    discard      = "on"
    iothread     = true
    ssd          = true
  }
  initialization {
    datastore_id = var.vm_storage
    dns {
      servers = local.dnsmask_vlan.ipv4_dns_servers
    }
    ip_config {
      ipv4 {
        address = each.value.ipv4_address
        gateway = local.dnsmask_vlan.ipv4_gateway
      }
    }
    user_account {
      username = var.ciuser
      password = var.cipassword
      keys     = var.cipubkey
    }
  }
  memory {
    dedicated = 1024
    floating  = 1024
  }
  network_device {
    bridge      = "vmbr0"
    mac_address = each.value.mac_address
    vlan_id     = local.dnsmask_vlan.vlan_id
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
