# proxmox_vm_qemu.pxe-bios-client:
resource "proxmox_vm_qemu" "pxe-bios-client" {
    agent                  = 1
    balloon                = 0
    bios                   = "seabios"
    boot                   = "order=net0;scsi0;ide2"
    clone                  = "debian12-template"
    cores                  = 2
    cpu                    = "x86-64-v2-AES"
    define_connection_info = false
    force_create           = false
    full_clone             = false
    hotplug                = "network,disk,usb"
    vmid                   = "401"
    kvm                    = true
    memory                 = 2048
    name                   = "pxe-bios-client"
    numa                   = false
    onboot                 = false
    oncreate               = false
    qemu_os                = "l26"
    scsihw                 = "virtio-scsi-single"
    sockets                = 1
    tablet                 = true
    target_node            = "pve2-mgt"
    vcpus                  = 0

    disk {
        backup             = true
        cache              = "none"
        discard            = "on"
        file               = "401/vm-401-disk-1.qcow2"
        format             = "qcow2"
        iops               = 0
        iops_max           = 0
        iops_max_length    = 0
        iops_rd            = 0
        iops_rd_max        = 0
        iops_rd_max_length = 0
        iops_wr            = 0
        iops_wr_max        = 0
        iops_wr_max_length = 0
        iothread           = 0
        mbps               = 0
        mbps_rd            = 0
        mbps_rd_max        = 0
        mbps_wr            = 0
        mbps_wr_max        = 0
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
        mtu       = 0
        queues    = 0
        rate      = 0
        tag       = 10
    }

    timeouts {}
}

# proxmox_vm_qemu.pxe-uefi-client:
resource "proxmox_vm_qemu" "pxe-uefi-client" {
    agent                  = 0
    balloon                = 0
    bios                   = "ovmf"
    boot                   = "order=net0;scsi0;ide2"
    clone                  = "debian12-template"
    cores                  = 2
    cpu                    = "x86-64-v2-AES"
    define_connection_info = false
    force_create           = false
    full_clone             = false
    hotplug                = "network,disk,usb"
    vmid                   = "400"
    kvm                    = true
    memory                 = 2048
    name                   = "pxe-uefi-client"
    numa                   = false
    onboot                 = false
    oncreate               = false
    qemu_os                = "l26"
    scsihw                 = "virtio-scsi-single"
    sockets                = 1
    tablet                 = true
    target_node            = "pve2-mgt"
    vcpus                  = 0

    disk {
        backup             = true
        cache              = "none"
        discard            = "on"
        file               = "400/vm-400-disk-1.qcow2"
        format             = "qcow2"
        iops               = 0
        iops_max           = 0
        iops_max_length    = 0
        iops_rd            = 0
        iops_rd_max        = 0
        iops_rd_max_length = 0
        iops_wr            = 0
        iops_wr_max        = 0
        iops_wr_max_length = 0
        iothread           = 0
        mbps               = 0
        mbps_rd            = 0
        mbps_rd_max        = 0
        mbps_wr            = 0
        mbps_wr_max        = 0
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
        firewall  = true
        link_down = false
        macaddr   = "5A:14:7D:CC:12:0F"
        model     = "virtio"
        mtu       = 0
        queues    = 0
        rate      = 0
        tag       = 10
    }

    timeouts {}
}
