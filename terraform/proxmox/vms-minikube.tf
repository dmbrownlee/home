locals {
  minikube_vlan = var.vlans[index(var.vlans.*.comment, "DMZ")]
}

resource "proxmox_virtual_environment_vm" "minikube" {
  depends_on = [
    proxmox_virtual_environment_vm.vm_templates,
    proxmox_virtual_environment_vm.dnsmasq
  ]
  for_each    = { for vm in var.vms : vm.hostname => vm if vm.role == "minikube" }
  name        = each.key
  description = "Managed by Terraform"
  tags        = ["terraform", each.value.cloud_init_image, each.value.role]
  node_name   = each.value.pve_node
  vm_id       = each.value.vm_id

  clone {
    datastore_id = var.vm_template_storage.name
    node_name    = var.vm_template_storage.node
    vm_id        = var.vm_templates[each.value.cloud_init_image].vm_id
    full         = true
  }
  cpu {
    sockets = 1
    cores   = 8
  }
  disk {
    datastore_id = var.vm_storage
    interface    = "scsi0"
    size         = 60
    discard      = "on"
    iothread     = true
    ssd          = true
  }
  initialization {
    datastore_id = var.vm_storage
    dns {
      servers = local.minikube_vlan.ipv4_dns_servers
    }
    ip_config {
      ipv4 {
        address = each.value.ipv4_address
        gateway = local.minikube_vlan.ipv4_gateway
      }
    }
    user_account {
      username = var.ciuser
      password = var.cipassword
      keys     = var.cipubkey
    }
  }
  memory {
    dedicated = 16384
    floating  = 16384
  }
  network_device {
    bridge      = "vmbr0"
    mac_address = each.value.mac_address
    vlan_id     = each.value.vlan_id
  }
  on_boot = false
  connection {
    type  = "ssh"
    user  = var.ciuser
    agent = true
    host  = self.name
  }
  provisioner "remote-exec" {
    inline = ["ip a"]
  }
  vga {
    type = "qxl"
  }
}
