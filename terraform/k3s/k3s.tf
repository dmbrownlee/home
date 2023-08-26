# proxmox_vm_qemu.k3s1:
resource "proxmox_vm_qemu" "k3s1" {
    agent                  = 1
    balloon                = 0
    bios                   = "ovmf"
    boot                   = "order=scsi0;ide2;net0"
    clone                  = "debian12-template"
    cores                  = 4
    cpu                    = "host"
    define_connection_info = false
    force_create           = false
    full_clone             = false
    hotplug                = "network,disk,usb"
    vmid                   = 610
    kvm                    = true
    memory                 = 16384
    name                   = "k3s1"
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
        file               = "610/vm-610-disk-1.qcow2"
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
        size               = "40G"
        slot               = 0
        ssd                = 0
        storage            = "truenas1"
        type               = "scsi"
        volume             = "truenas1:610/vm-610-disk-1.qcow2"
    }

    network {
        bridge    = "vmbr0"
        firewall  = true
        link_down = false
        macaddr   = "ca:fe:01:04:01:01"
        model     = "virtio"
        mtu       = 0
        queues    = 0
        rate      = 0
        tag       = 30
    }

    timeouts {}
}
