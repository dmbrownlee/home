# proxmox_vm_qemu.ansible2:
resource "proxmox_vm_qemu" "ansible-green" {
    agent                  = 1
    balloon                = 0
    bios                   = "ovmf"
    boot                   = "order=scsi0;ide2;net0"
    clone                  = "debian12-workstation-green"
    cores                  = 8
    cpu                    = "x86-64-v2-AES"
    define_connection_info = false
    force_create           = false
    full_clone             = false
    hotplug                = "network,disk,usb"
    vmid                   = "200"
    kvm                    = true
    memory                 = 8192
    name                   = "ansible-green"
    numa                   = false
    onboot                 = true
    oncreate               = true
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
        file               = "200/vm-200-disk-1.qcow2"
        iops               = 0
        iops_max           = 0
        iops_max_length    = 0
        iops_rd            = 0
        iops_rd_max        = 0
        iops_rd_max_length = 0
        iops_wr            = 0
        iops_wr_max        = 0
        iops_wr_max_length = 0
        iothread           = 1
        mbps               = 0
        mbps_rd            = 0
        mbps_rd_max        = 0
        mbps_wr            = 0
        mbps_wr_max        = 0
        replicate          = 0
        size               = "60G"
        slot               = 0
        ssd                = 1
        storage            = "truenas1"
        type               = "scsi"
        volume             = "truenas1:200/vm-200-disk-1.qcow2"
    }

    network {
        bridge    = "vmbr0"
        firewall  = true
        link_down = false
        macaddr   = "CA:FE:01:02:01:01"
        model     = "virtio"
        mtu       = 0
        queues    = 0
        rate      = 0
        tag       = 30
    }
}

# proxmox_vm_qemu.git2:
resource "proxmox_vm_qemu" "git-green" {
    agent                  = 1
    balloon                = 0
    bios                   = "ovmf"
    boot                   = "order=scsi0;ide2;net0"
    clone                  = "debian12-minimal-green"
    cores                  = 1
    cpu                    = "x86-64-v2-AES"
    define_connection_info = false
    force_create           = false
    full_clone             = false
    hotplug                = "network,disk,usb"
    vmid                   = "201"
    kvm                    = true
    memory                 = 2048
    name                   = "git-green"
    numa                   = false
    onboot                 = true
    oncreate               = true
    qemu_os                = "l26"
    scsihw                 = "virtio-scsi-single"
    sockets                = 1
    tablet                 = true
    target_node            = "pve2-mgt"
    vcpus                  = 0

    disk {
        backup             = true
        cache              = "none"
        file               = "201/vm-201-disk-1.qcow2"
        iops               = 0
        iops_max           = 0
        iops_max_length    = 0
        iops_rd            = 0
        iops_rd_max        = 0
        iops_rd_max_length = 0
        iops_wr            = 0
        iops_wr_max        = 0
        iops_wr_max_length = 0
        iothread           = 1
        mbps               = 0
        mbps_rd            = 0
        mbps_rd_max        = 0
        mbps_wr            = 0
        mbps_wr_max        = 0
        replicate          = 0
        size               = "32G"
        slot               = 0
        ssd                = 0
        storage            = "truenas1"
        type               = "scsi"
        volume             = "truenas1:201/vm-201-disk-1.qcow2"
    }

    network {
        bridge    = "vmbr0"
        firewall  = true
        link_down = false
        macaddr   = "CA:FE:01:02:02:01"
        model     = "virtio"
        mtu       = 0
        queues    = 0
        rate      = 0
        tag       = 30
    }
}

# proxmox_vm_qemu.netbox2:
resource "proxmox_vm_qemu" "netbox-green" {
    agent                  = 1
    balloon                = 0
    bios                   = "ovmf"
    boot                   = "order=scsi0;ide2;net0"
    clone                  = "debian12-workstation-green"
    cores                  = 4
    cpu                    = "host"
    define_connection_info = false
    force_create           = false
    full_clone             = false
    hotplug                = "network,disk,usb"
    vmid                   = "202"
    kvm                    = true
    memory                 = 4096
    name                   = "netbox-green"
    numa                   = false
    onboot                 = true
    oncreate               = true
    qemu_os                = "l26"
    scsihw                 = "virtio-scsi-single"
    sockets                = 1
    tablet                 = true
    target_node            = "pve2-mgt"
    vcpus                  = 0

    disk {
        backup             = true
        cache              = "none"
        file               = "202/vm-202-disk-1.qcow2"
        iops               = 0
        iops_max           = 0
        iops_max_length    = 0
        iops_rd            = 0
        iops_rd_max        = 0
        iops_rd_max_length = 0
        iops_wr            = 0
        iops_wr_max        = 0
        iops_wr_max_length = 0
        iothread           = 1
        mbps               = 0
        mbps_rd            = 0
        mbps_rd_max        = 0
        mbps_wr            = 0
        mbps_wr_max        = 0
        replicate          = 0
        size               = "32G"
        slot               = 0
        ssd                = 0
        storage            = "truenas1"
        type               = "scsi"
        volume             = "truenas1:202/vm-202-disk-1.qcow2"
    }

    network {
        bridge    = "vmbr0"
        firewall  = true
        link_down = false
        macaddr   = "CA:FE:01:02:03:01"
        model     = "virtio"
        mtu       = 0
        queues    = 0
        rate      = 0
        tag       = 30
    }
}

# proxmox_vm_qemu.pxe2:
resource "proxmox_vm_qemu" "pxe-green" {
    agent                  = 1
    balloon                = 0
    bios                   = "ovmf"
    boot                   = "order=scsi0;ide2;net0"
    clone                  = "debian12-minimal-green"
    cores                  = 2
    cpu                    = "x86-64-v2-AES"
    define_connection_info = false
    force_create           = false
    full_clone             = false
    hotplug                = "network,disk,usb"
    vmid                   = "203"
    kvm                    = true
    memory                 = 2048
    name                   = "pxe-green"
    numa                   = false
    onboot                 = true
    oncreate               = true
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
        file               = "203/vm-203-disk-1.qcow2"
        iops               = 0
        iops_max           = 0
        iops_max_length    = 0
        iops_rd            = 0
        iops_rd_max        = 0
        iops_rd_max_length = 0
        iops_wr            = 0
        iops_wr_max        = 0
        iops_wr_max_length = 0
        iothread           = 1
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
        volume             = "truenas1:203/vm-203-disk-1.qcow2"
    }

    network {
        bridge    = "vmbr0"
        firewall  = true
        link_down = false
        macaddr   = "CA:FE:01:02:04:01"
        model     = "virtio"
        mtu       = 0
        queues    = 0
        rate      = 0
        tag       = 30
    }
    network {
        bridge    = "vmbr0"
        firewall  = true
        link_down = false
        macaddr   = "CA:FE:01:02:04:02"
        model     = "virtio"
        mtu       = 0
        queues    = 0
        rate      = 0
        tag       = 10
    }
}

# proxmox_vm_qemu.registry2:
resource "proxmox_vm_qemu" "registry-green" {
    agent                  = 1
    balloon                = 0
    bios                   = "ovmf"
    boot                   = "order=scsi0;ide2;net0"
    clone                  = "debian12-minimal-green"
    cores                  = 2
    cpu                    = "x86-64-v2-AES"
    define_connection_info = false
    force_create           = false
    full_clone             = false
    hotplug                = "network,disk,usb"
    vmid                   = "204"
    kvm                    = true
    memory                 = 2048
    name                   = "registry-green"
    numa                   = false
    onboot                 = true
    oncreate               = true
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
        file               = "204/vm-204-disk-1.qcow2"
        iops               = 0
        iops_max           = 0
        iops_max_length    = 0
        iops_rd            = 0
        iops_rd_max        = 0
        iops_rd_max_length = 0
        iops_wr            = 0
        iops_wr_max        = 0
        iops_wr_max_length = 0
        iothread           = 1
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
        volume             = "truenas1:204/vm-204-disk-1.qcow2"
    }

    network {
        bridge    = "vmbr0"
        firewall  = true
        link_down = false
        macaddr   = "CA:FE:01:02:05:01"
        model     = "virtio"
        mtu       = 0
        queues    = 0
        rate      = 0
        tag       = 30
    }
    network {
        bridge    = "vmbr0"
        firewall  = true
        link_down = false
        macaddr   = "CA:FE:01:02:05:02"
        model     = "virtio"
        mtu       = 0
        queues    = 0
        rate      = 0
        tag       = 10
    }
}
