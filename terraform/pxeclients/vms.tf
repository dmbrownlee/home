# proxmox_vm_qemu.pxe-bios-client:
resource "proxmox_vm_qemu" "pxe-bios-client" {
    lifecycle {
        ignore_changes = [
            # The packer generated templates contain a note with a timestamp
            # as to when the template was created.  Changed in this note can
            # be ignored.
            desc,
        ]
    }

    agent                  = 1
    balloon                = 1
    bios                   = "seabios"
    boot                   = "order=net0;scsi0;ide2"
    clone                  = "debian12-minimal-green"
    cores                  = 2
    cpu                    = "x86-64-v2-AES"
    define_connection_info = false
    full_clone             = false
    memory                 = 2048
    name                   = "pxe-bios-client"
    onboot                 = false
    oncreate               = false
    qemu_os                = "l26"
    scsihw                 = "virtio-scsi-single"
    sockets                = 1
    tablet                 = true
    target_node            = "pve2-mgt"
    vmid                   = "401"

    disk {
        backup             = false
        cache              = "none"
        discard            = "on"
        file               = "401/vm-401-disk-1.qcow2"
        iothread           = 1
        replicate          = 0
        size               = "32G"
        slot               = 0
        ssd                = 1
        storage            = "truenas1"
        type               = "scsi"
        volume             = "truenas1:401/vm-401-disk-1.qcow2"
    }

    network {
        bridge    = "vmbr0"
        firewall  = true
        link_down = false
        macaddr   = "66:F8:78:46:80:1E"
        model     = "virtio"
        tag       = 10
    }

    timeouts {}

    vga {
        type = "qxl"
    }
}

# proxmox_vm_qemu.pxe-uefi-client:
resource "proxmox_vm_qemu" "pxe-uefi-client" {
    lifecycle {
        ignore_changes = [
            # The packer generated templates contain a note with a timestamp
            # as to when the template was created.  Changed in this note can
            # be ignored.
            desc,
        ]
    }

    agent                  = 0
    balloon                = 1
    bios                   = "ovmf"
    boot                   = "order=net0;scsi0;ide2"
    clone                  = "debian12-minimal-green"
    cores                  = 2
    cpu                    = "x86-64-v2-AES"
    define_connection_info = false
    full_clone             = false
    memory                 = 2048
    name                   = "pxe-uefi-client"
    onboot                 = false
    oncreate               = false
    qemu_os                = "l26"
    scsihw                 = "virtio-scsi-single"
    sockets                = 1
    tablet                 = true
    target_node            = "pve2-mgt"
    vmid                   = "400"

    disk {
        backup             = true
        cache              = "none"
        discard            = "on"
        file               = "400/vm-400-disk-1.qcow2"
        iothread           = 1
        replicate          = 0
        size               = "32G"
        slot               = 0
        ssd                = 1
        storage            = "truenas1"
        type               = "scsi"
        volume             = "truenas1:400/vm-400-disk-1.qcow2"
    }

    network {
        bridge    = "vmbr0"
        link_down = false
        macaddr   = "5A:14:7D:CC:12:0F"
        model     = "virtio"
        tag       = 10
    }

    timeouts {}

    vga {
        type = "qxl"
    }
}
