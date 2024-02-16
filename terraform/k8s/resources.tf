resource "proxmox_virtual_environment_vm" "k8scp1" {
  name        = "k8scp1"
  description = "Managed by Terraform"
  tags        = ["debian12-genericcloud", "k8s", "terraform"]
  node_name   = "pve1"
  vm_id       = 401

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
    mac_address = "ca:fe:01:05:01:01"
    vlan_id     = 1001
  }
  on_boot = false
}

resource "proxmox_virtual_environment_vm" "k8scp2" {
  name        = "k8scp2"
  description = "Managed by Terraform"
  tags        = ["debian12-genericcloud", "k8s", "terraform"]
  node_name   = "pve1"
  vm_id       = 402

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
    mac_address = "ca:fe:01:05:02:01"
    vlan_id     = 1001
  }
  on_boot = false
}

resource "proxmox_virtual_environment_vm" "k8scp3" {
  name        = "k8scp3"
  description = "Managed by Terraform"
  tags        = ["debian12-genericcloud", "k8s", "terraform"]
  node_name   = "pve1"
  vm_id       = 403

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
    mac_address = "ca:fe:01:05:03:01"
    vlan_id     = 1001
  }
  on_boot = false
}

resource "proxmox_virtual_environment_vm" "k8sw1" {
  name        = "k8sw1"
  description = "Managed by Terraform"
  tags        = ["debian12-genericcloud", "k8s", "terraform"]
  node_name   = "pve1"
  vm_id       = 404

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
    mac_address = "ca:fe:01:05:04:01"
    vlan_id     = 1001
  }
  on_boot = false
}

resource "proxmox_virtual_environment_vm" "k8sw2" {
  name        = "k8sw2"
  description = "Managed by Terraform"
  tags        = ["debian12-genericcloud", "k8s", "terraform"]
  node_name   = "pve1"
  vm_id       = 405

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
    mac_address = "ca:fe:01:05:05:01"
    vlan_id     = 1001
  }
  on_boot = false
}

