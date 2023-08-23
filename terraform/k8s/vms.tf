resource "proxmox_vm_qemu" "k8s_node1" {
    agent                  = 1
    bios                   = "ovmf"
    boot                   = "order=ide2;scsi0;net0"
    clone                  = "debian12-template"
    cores                  = 2
    cpu                    = "host"
    define_connection_info = false
    force_create           = false
    full_clone             = false
    hotplug                = "network,disk,usb"
    vmid                   = 260
    kvm                    = true
    memory                 = 4096
    name                   = "k8s-node1"
    numa                   = false
    onboot                 = false
    oncreate               = true
    qemu_os                = "l26"
    scsihw                 = "virtio-scsi-pci"
    sockets                = 1
    tablet                 = true
    target_node            = "pve2-mgt"
    vcpus                  = 0

    disk {
        backup             = true
        cache              = "none"
        discard            = "on"
        file               = "260/vm-260-disk-1.qcow2"
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
        size               = "60G"
        slot               = 0
        ssd                = 1
        storage            = "truenas1"
        type               = "scsi"
        volume             = "truenas1:260/vm-260-disk-1.qcow2"
    }

    network {
        bridge    = "vmbr0"
        firewall  = true
        link_down = false
        macaddr   = "aa:aa:ac:00:00:00"
        model     = "virtio"
        mtu       = 0
        queues    = 0
        rate      = 0
        tag       = 30
    }

    timeouts {}
}

resource "proxmox_vm_qemu" "k8s_node2" {
    agent                  = 1
    bios                   = "ovmf"
    boot                   = "order=ide2;scsi0;net0"
    clone                  = "debian12-template"
    cores                  = 2
    cpu                    = "host"
    define_connection_info = false
    force_create           = false
    full_clone             = false
    hotplug                = "network,disk,usb"
    vmid                   = 261
    kvm                    = true
    memory                 = 4096
    name                   = "k8s-node2"
    numa                   = false
    onboot                 = false
    oncreate               = true
    qemu_os                = "l26"
    scsihw                 = "virtio-scsi-pci"
    sockets                = 1
    tablet                 = true
    target_node            = "pve2-mgt"
    vcpus                  = 0

    disk {
        backup             = true
        cache              = "none"
        discard            = "on"
        file               = "261/vm-261-disk-1.qcow2"
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
        size               = "60G"
        slot               = 0
        ssd                = 1
        storage            = "truenas1"
        type               = "scsi"
        volume             = "truenas1:261/vm-261-disk-1.qcow2"
    }

    network {
        bridge    = "vmbr0"
        firewall  = true
        link_down = false
        macaddr   = "aa:aa:ac:00:01:00"
        model     = "virtio"
        mtu       = 0
        queues    = 0
        rate      = 0
        tag       = 30
    }

    timeouts {}
}

resource "proxmox_vm_qemu" "k8s_node3" {
    agent                  = 1
    bios                   = "ovmf"
    boot                   = "order=ide2;scsi0;net0"
    clone                  = "debian12-template"
    cores                  = 2
    cpu                    = "host"
    define_connection_info = false
    force_create           = false
    full_clone             = false
    hotplug                = "network,disk,usb"
    vmid                   = 262
    kvm                    = true
    memory                 = 4096
    name                   = "k8s-node3"
    numa                   = false
    onboot                 = false
    oncreate               = true
    qemu_os                = "l26"
    scsihw                 = "virtio-scsi-pci"
    sockets                = 1
    tablet                 = true
    target_node            = "pve2-mgt"
    vcpus                  = 0

    disk {
        backup             = true
        cache              = "none"
        discard            = "on"
        file               = "262/vm-262-disk-1.qcow2"
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
        size               = "60G"
        slot               = 0
        ssd                = 1
        storage            = "truenas1"
        type               = "scsi"
        volume             = "truenas1:262/vm-262-disk-1.qcow2"
    }

    network {
        bridge    = "vmbr0"
        firewall  = true
        link_down = false
        macaddr   = "aa:aa:ac:00:02:00"
        model     = "virtio"
        mtu       = 0
        queues    = 0
        rate      = 0
        tag       = 30
    }

    timeouts {}
}

