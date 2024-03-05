resource "proxmox_virtual_environment_vm" "control_plane_nodes" {
  for_each    = { for n in var.control_plane_nodes:
                    n.hostname => {
                      pve_node = n.pve_node,
                      mac_address = n.mac_address,
                      vm_id = n.vm_id
                    }
                }
  name        = each.key
  description = "Managed by Terraform"
  tags        = ["debian12-genericcloud", "k8s", "terraform"]
  node_name   = each.value.pve_node
  vm_id       = each.value.vm_id

  clone {
    datastore_id = "truenas1"
    node_name    = "pve3"
    vm_id        = 999
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
    ip_config {
      ipv4 {
        address = "dhcp"
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
    vlan_id     = 1001
  }
  on_boot = false
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

resource "ansible_host" "control_plane_nodes" {
  for_each    = toset([ for n in var.control_plane_nodes: n.hostname ])
  name        = each.key
  groups = ["control_plane_nodes"]
  depends_on = [
    resource.proxmox_virtual_environment_vm.control_plane_nodes
  ]
}

resource "proxmox_virtual_environment_vm" "worker_nodes" {
  for_each    = { for n in var.worker_nodes:
                    n.hostname => {
                      pve_node = n.pve_node,
                      mac_address = n.mac_address,
                      vm_id = n.vm_id
                    }
                }
  name        = each.key
  description = "Managed by Terraform"
  tags        = ["debian12-genericcloud", "k8s", "terraform"]
  node_name   = each.value.pve_node
  vm_id       = each.value.vm_id

  clone {
    datastore_id = "truenas1"
    node_name    = "pve3"
    vm_id        = 999
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
    ip_config {
      ipv4 {
        address = "dhcp"
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
    vlan_id     = 1001
  }
  on_boot = false
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

resource "ansible_host" "worker_nodes" {
  for_each    = toset([ for n in var.worker_nodes: n.hostname ])
  name        = each.key
  groups = ["worker_nodes"]
  depends_on = [
    resource.proxmox_virtual_environment_vm.control_plane_nodes
  ]
}

resource "ansible_playbook" "control_plane_nodes" {
  for_each    = toset([ for n in var.control_plane_nodes: n.hostname ])
  playbook   = "playbook.yml"
  name       = each.key
  replayable = true
  ignore_playbook_failure = true
  extra_vars = {
    private_key      = var.ssh_private_key_files[var.ciuser]
    ansible_ssh_user = var.ciuser
  }
  depends_on = [
    resource.ansible_host.control_plane_nodes
  ]
}

resource "ansible_playbook" "worker_nodes" {
  for_each    = toset([ for n in var.worker_nodes: n.hostname ])
  playbook   = "playbook.yml"
  name       = each.key
  replayable = true
  ignore_playbook_failure = true
  extra_vars = {
    private_key      = var.ssh_private_key_files[var.ciuser]
    ansible_ssh_user = var.ciuser
  }
  depends_on = [
    resource.ansible_host.worker_nodes
  ]
}

output "cp_playbook_output" {
  value = ansible_playbook.control_plane_nodes
}

output "worker_playbook_output" {
  value = ansible_playbook.worker_nodes
}

