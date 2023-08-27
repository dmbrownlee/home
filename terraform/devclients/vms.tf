resource "proxmox_vm_qemu" "framework1-dev" {
    agent                  = 1
    bios                   = "ovmf"
    boot                   = "order=scsi0;ide2;net0"
    clone                  = "debian12-uefi-workstation"
    cores                  = 2
    cpu                    = "x86-64-v2-AES"
    desc                   = "framework1-dev"
    full_clone             = false
    memory                 = 4096
    name                   = "framework1-dev"
    onboot                 = false
    oncreate               = true
    qemu_os                = "l26"
    scsihw                 = "virtio-scsi-single"
    sockets                = 1
    target_node            = "pve2-mgt"
    vmid                   = 500

    disk {
        backup             = false
        cache              = "none"
        discard            = "on"
        file               = "500/vm-500-disk-1.qcow2"
        format             = "qcow2"
        iothread           = 1
        replicate          = 0
        size               = "32G"
        slot               = 0
        ssd                = 1
        storage            = "truenas1"
        type               = "scsi"
        volume             = "truenas1:500/vm-500-disk-1.qcow2"
    }

    network {
        bridge    = "vmbr0"
        macaddr   = "ca:fe:01:06:01:01"
        model     = "virtio"
        tag       = 10
    }

    timeouts {}

    vga {
        type = "qxl"
    }
}

resource "proxmox_vm_qemu" "framework2-dev" {
    agent                  = 1
    bios                   = "ovmf"
    boot                   = "order=scsi0;ide2;net0"
    clone                  = "fedora38-workstation-template"
    cores                  = 2
    cpu                    = "x86-64-v2-AES"
    desc                   = "framework2-dev"
    full_clone             = false
    memory                 = 8192
    name                   = "framework2-dev"
    onboot                 = false
    oncreate               = true
    qemu_os                = "l26"
    scsihw                 = "virtio-scsi-single"
    sockets                = 1
    target_node            = "pve2-mgt"
    vmid                   = 501

    disk {
        backup             = false
        cache              = "none"
        discard            = "on"
        file               = "501/vm-501-disk-1.qcow2"
        format             = "qcow2"
        iothread           = 1
        replicate          = 0
        size               = "32G"
        slot               = 0
        ssd                = 1
        storage            = "truenas1"
        type               = "scsi"
        volume             = "truenas1:501/vm-501-disk-1.qcow2"
    }

    network {
        bridge    = "vmbr0"
        macaddr   = "ca:fe:01:06:02:01"
        model     = "virtio"
        tag       = 10
    }

    timeouts {}

    vga {
        type = "qxl"
    }
}

resource "proxmox_vm_qemu" "workstation1-dev" {
    agent                  = 1
    bios                   = "ovmf"
    boot                   = "order=scsi0;ide2;net0"
    clone                  = "fedora38-workstation-template"
    cores                  = 2
    cpu                    = "x86-64-v2-AES"
    desc                   = "workstation1-dev"
    full_clone             = false
    memory                 = 8192
    name                   = "workstation1-dev"
    onboot                 = false
    oncreate               = true
    qemu_os                = "l26"
    scsihw                 = "virtio-scsi-single"
    sockets                = 1
    target_node            = "pve2-mgt"
    vmid                   = 502

    disk {
        backup             = false
        cache              = "none"
        discard            = "on"
        file               = "502/vm-502-disk-1.qcow2"
        format             = "qcow2"
        iothread           = 1
        replicate          = 0
        size               = "32G"
        slot               = 0
        ssd                = 1
        storage            = "truenas1"
        type               = "scsi"
        volume             = "truenas1:502/vm-502-disk-1.qcow2"
    }

    network {
        bridge    = "vmbr0"
        macaddr   = "ca:fe:01:06:03:01"
        model     = "virtio"
        tag       = 10
    }

    timeouts {}

    vga {
        type = "qxl"
    }
}
