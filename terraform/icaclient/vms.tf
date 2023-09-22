variable "provision_username" {
  type = string
}

resource "proxmox_vm_qemu" "icaclient" {
  lifecycle {
    ignore_changes = [
      # The packer generated templates contain a note with a timestamp
      # as to when the template was created.  Changed in this note can
      # be ignored.
      desc,
    ]
  }

  agent       = 1
  bios        = "ovmf"
  boot        = "order=scsi0;ide2;net0"
  clone       = "debian12-workstation-green"
  cores       = 4
  cpu         = "x86-64-v2-AES"
  desc        = "icaclient"
  full_clone  = true
  memory      = 8192
  name        = "icaclient"
  onboot      = false
  oncreate    = true
  qemu_os     = "l26"
  scsihw      = "virtio-scsi-single"
  sockets     = 1
  target_node = "pve3-mgt"
  vmid        = 1003

  disk {
    backup    = false
    cache     = "none"
    discard   = "on"
    file      = "1003/vm-1003-disk-1.raw"
    format    = "raw"
    iothread  = 1
    replicate = 0
    size      = "80G"
    slot      = 0
    ssd       = 1
    storage   = "truenas1"
    type      = "scsi"
    volume    = "truenas1:1003/vm-1003-disk-1.raw"
  }

  network {
    bridge  = "vmbr0"
    macaddr = "ca:fe:01:07:01:01"
    model   = "virtio"
    tag     = 30
  }

  timeouts {}

  vga {
    type = "qxl"
  }

  provisioner "remote-exec" {
    inline = ["ip a"]

    connection {
      host  = self.name
      type  = "ssh"
      user  = var.provision_username
      agent = true
    }
  }

  provisioner "local-exec" {
    command     = "ansible-playbook -i inv.icaclient.yml -l ${self.name} -u ${var.provision_username} site.yml"
    working_dir = "../../ansible"
  }
}
