locals {
  control_plane_nodes = [
    { vm_id = 401, hostname = "k8scp1", mac_address = "ca:fe:01:05:01:01" },
    { vm_id = 402, hostname = "k8scp2", mac_address = "ca:fe:01:05:02:01" },
    { vm_id = 403, hostname = "k8scp3", mac_address = "ca:fe:01:05:03:01" }
  ]
  worker_nodes = [
    { vm_id = 404, hostname = "k8sw1", mac_address = "ca:fe:01:05:04:01" },
    { vm_id = 405, hostname = "k8sw2", mac_address = "ca:fe:01:05:05:01" }
  ]
}

resource "proxmox_virtual_environment_vm" "control_plane_nodes" {
  for_each    = { for node in local.control_plane_nodes: node.hostname => { mac_address = node.mac_address, vm_id = node.vm_id } }
  name        = each.key
  description = "Managed by Terraform"
  tags        = ["debian12-genericcloud", "k8s", "terraform"]
  node_name   = "pve1"
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
      keys     = ["ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCvfVK4u6FX5aWXcQIX3h0vQh+YywyJ3A+SV7soleU21f+7NZfkm9PybLnSFq5QbOdRZRe9kcLAGrGG8apNGTsZH2y25kt3HQm5PLS4E+jKg9An+fqk+4XMfRYWb71ZPZo5J8M5xOtL3VjNVS+9pDLeWhAw0OMlyl8+6QZnHg/+vOysJ4PebBiI7Nr2QjRh8h3hCB4xDe3f+U+GDML0A18pfgBS66y/JqKS+P+p2BsBnYLDZlAr/8Q3JWKfGra1yhftT3rEiZmIK+RT9qUeMgzyMC/rJa5lb7LJ2p4n3utsk90HlE0R4xDrSTk7ZkU/MxsHFmsc9JSx522DNXthlaz0U+GZgctBydWPYxAWdj2tjjniiJm4iZdt3pg4qPtr8fBWveyEzXuo6Yw66sA91Z6GOJA/ltmZjQUyh5d4M4NV+kFlydvEXHLVIfrUq51cDFGPHBhxkkIp32Lvrwvq45sKTiMbHt5xpTVHClrQE55SvJePNMtaJV6YDZ0zRJ9nonVULrIY+j/kNKSe7UtAdGWoNRyTGTi3O59pD3eRlBkFqxUV9fZ43TCBTNswubuF0RIyTyPqkOr0OGANq6mgp/Cuy0C9TE6FKWTyt9ygrZ3Xsw4B9gn6t2K96QgH8wO7rBtvJiB6liOwv8Thze8M3dphrBo4ka/IFRq/Ust8xvH3yQ=="]
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
}

resource "ansible_host" "control_plane_nodes" {
  for_each    = toset([ for node in local.control_plane_nodes: node.hostname ])
  name        = each.value
  groups = ["control_plane_nodes"]
  depends_on = [
    resource.proxmox_virtual_environment_vm.control_plane_nodes
  ]
}

resource "proxmox_virtual_environment_vm" "worker_nodes" {
  for_each    = { for node in local.worker_nodes: node.hostname => { mac_address = node.mac_address, vm_id = node.vm_id } }
  name        = each.key
  description = "Managed by Terraform"
  tags        = ["debian12-genericcloud", "k8s", "terraform"]
  node_name   = "pve1"
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
      keys     = ["ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCvfVK4u6FX5aWXcQIX3h0vQh+YywyJ3A+SV7soleU21f+7NZfkm9PybLnSFq5QbOdRZRe9kcLAGrGG8apNGTsZH2y25kt3HQm5PLS4E+jKg9An+fqk+4XMfRYWb71ZPZo5J8M5xOtL3VjNVS+9pDLeWhAw0OMlyl8+6QZnHg/+vOysJ4PebBiI7Nr2QjRh8h3hCB4xDe3f+U+GDML0A18pfgBS66y/JqKS+P+p2BsBnYLDZlAr/8Q3JWKfGra1yhftT3rEiZmIK+RT9qUeMgzyMC/rJa5lb7LJ2p4n3utsk90HlE0R4xDrSTk7ZkU/MxsHFmsc9JSx522DNXthlaz0U+GZgctBydWPYxAWdj2tjjniiJm4iZdt3pg4qPtr8fBWveyEzXuo6Yw66sA91Z6GOJA/ltmZjQUyh5d4M4NV+kFlydvEXHLVIfrUq51cDFGPHBhxkkIp32Lvrwvq45sKTiMbHt5xpTVHClrQE55SvJePNMtaJV6YDZ0zRJ9nonVULrIY+j/kNKSe7UtAdGWoNRyTGTi3O59pD3eRlBkFqxUV9fZ43TCBTNswubuF0RIyTyPqkOr0OGANq6mgp/Cuy0C9TE6FKWTyt9ygrZ3Xsw4B9gn6t2K96QgH8wO7rBtvJiB6liOwv8Thze8M3dphrBo4ka/IFRq/Ust8xvH3yQ=="]
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
}

resource "ansible_host" "worker_nodes" {
  for_each    = toset([ for node in local.worker_nodes: node.hostname ])
  name        = each.value
  groups = ["worker_nodes"]
  depends_on = [
    resource.proxmox_virtual_environment_vm.control_plane_nodes
  ]
}

resource "ansible_playbook" "control_plane_nodes" {
  for_each    = toset([ for node in local.control_plane_nodes: node.hostname ])
  playbook   = "playbook.yml"
  name       = each.value
  replayable = true
  ignore_playbook_failure = true
  extra_vars = {
    private_key      = var.ssh_private_keys[var.ciuser]
    ansible_ssh_user = var.ciuser
  }
  depends_on = [
    resource.ansible_host.control_plane_nodes
  ]
}

resource "ansible_playbook" "worker_nodes" {
  for_each    = toset([ for node in local.worker_nodes: node.hostname ])
  playbook   = "playbook.yml"
  name       = each.value
  replayable = true
  ignore_playbook_failure = true
  extra_vars = {
    private_key      = var.ssh_private_keys[var.ciuser]
    ansible_ssh_user = var.ciuser
  }
  depends_on = [
    resource.ansible_host.worker_nodes
  ]
}

output "cp_playbook_stderr" {
  value = ansible_playbook.control_plane_nodes
}

output "cp_playbook_stdout" {
  value = ansible_playbook.control_plane_nodes
}

output "worker_playbook_stderr" {
  value = ansible_playbook.worker_nodes
}

output "worker_playbook_stdout" {
  value = ansible_playbook.worker_nodes
}

