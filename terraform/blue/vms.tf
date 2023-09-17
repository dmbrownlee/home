variable "provision_username" {
    type = string
}

# proxmox_vm_qemu.ansible1:
resource "proxmox_vm_qemu" "ansible1" {
    lifecycle {
        ignore_changes = [
            # The packer generated templates contain a note with a timestamp
            # as to when the template was created.  Changed in this note can
            # be ignored.
            desc,
        ]
    }

    agent                  = 1
    balloon                = 0
    bios                   = "ovmf"
    boot                   = "order=scsi0;ide2;net0"
    clone                  = "debian12-workstation-blue"
    cores                  = 8
    cpu                    = "x86-64-v2-AES"
    define_connection_info = false
    force_create           = false
    full_clone             = false
    hotplug                = "network,disk,usb"
    vmid                   = "300"
    kvm                    = true
    memory                 = 8192
    name                   = "ansible1"
    numa                   = false
    onboot                 = true
    oncreate               = true
    qemu_os                = "l26"
    scsihw                 = "virtio-scsi-single"
    sockets                = 1
    tablet                 = true
    target_node            = "pve1-mgt"
    vcpus                  = 0

    disk {
        backup             = true
        cache              = "none"
        discard            = "on"
        file               = "300/vm-300-disk-1.qcow2"
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
        volume             = "truenas1:300/vm-300-disk-1.qcow2"
    }

    network {
        bridge    = "vmbr0"
        firewall  = true
        link_down = false
        macaddr   = "CA:FE:01:01:01:01"
        model     = "virtio"
        mtu       = 0
        queues    = 0
        rate      = 0
        tag       = 30
    }

    provisioner "remote-exec" {
        inline = ["ip a"]

        connection {
            host        = self.name
            type        = "ssh"
            user        = var.provision_username
            agent       = true
        }
    }

    provisioner "local-exec" {
        command = "ansible-playbook -i inv.blue.yml -l ${self.name} -u ${var.provision_username} site.yml"
        working_dir = "../../ansible"
    }
}

# proxmox_vm_qemu.git1:
resource "proxmox_vm_qemu" "git1" {
    lifecycle {
        ignore_changes = [
            # The packer generated templates contain a note with a timestamp
            # as to when the template was created.  Changed in this note can
            # be ignored.
            desc,
        ]
    }

    agent                  = 1
    balloon                = 0
    bios                   = "ovmf"
    boot                   = "order=scsi0;ide2;net0"
    clone                  = "debian12-minimal-blue"
    cores                  = 1
    cpu                    = "x86-64-v2-AES"
    define_connection_info = false
    force_create           = false
    full_clone             = false
    hotplug                = "network,disk,usb"
    vmid                   = "301"
    kvm                    = true
    memory                 = 2048
    name                   = "git1"
    numa                   = false
    onboot                 = true
    oncreate               = true
    qemu_os                = "l26"
    scsihw                 = "virtio-scsi-single"
    sockets                = 1
    tablet                 = true
    target_node            = "pve1-mgt"
    vcpus                  = 0

    disk {
        backup             = true
        cache              = "none"
        file               = "301/vm-301-disk-1.qcow2"
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
        volume             = "truenas1:301/vm-301-disk-1.qcow2"
    }

    network {
        bridge    = "vmbr0"
        firewall  = true
        link_down = false
        macaddr   = "CA:FE:01:01:02:01"
        model     = "virtio"
        mtu       = 0
        queues    = 0
        rate      = 0
        tag       = 30
    }

    provisioner "remote-exec" {
        inline = ["ip a"]

        connection {
            host        = self.name
            type        = "ssh"
            user        = var.provision_username
            agent       = true
        }
    }

    provisioner "local-exec" {
        command = "ansible-playbook -i inv.blue.yml -l ${self.name} -u ${var.provision_username} site.yml"
        working_dir = "../../ansible"
    }
}

# proxmox_vm_qemu.netbox1:
resource "proxmox_vm_qemu" "netbox1" {
    lifecycle {
        ignore_changes = [
            # The packer generated templates contain a note with a timestamp
            # as to when the template was created.  Changed in this note can
            # be ignored.
            desc,
        ]
    }

    agent                  = 1
    balloon                = 0
    bios                   = "ovmf"
    boot                   = "order=scsi0;ide2;net0"
    clone                  = "debian12-workstation-blue"
    cores                  = 4
    cpu                    = "host"
    define_connection_info = false
    force_create           = false
    full_clone             = false
    hotplug                = "network,disk,usb"
    vmid                   = "302"
    kvm                    = true
    memory                 = 4096
    name                   = "netbox1"
    numa                   = false
    onboot                 = true
    oncreate               = true
    qemu_os                = "l26"
    scsihw                 = "virtio-scsi-single"
    sockets                = 1
    tablet                 = true
    target_node            = "pve1-mgt"
    vcpus                  = 0

    disk {
        backup             = true
        cache              = "none"
        file               = "302/vm-302-disk-1.qcow2"
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
        volume             = "truenas1:302/vm-302-disk-1.qcow2"
    }

    network {
        bridge    = "vmbr0"
        firewall  = true
        link_down = false
        macaddr   = "CA:FE:01:01:03:01"
        model     = "virtio"
        mtu       = 0
        queues    = 0
        rate      = 0
        tag       = 30
    }

    provisioner "remote-exec" {
        inline = ["ip a"]

        connection {
            host        = self.name
            type        = "ssh"
            user        = var.provision_username
            agent       = true
        }
    }

    provisioner "local-exec" {
        command = "ansible-playbook -i inv.blue.yml -l ${self.name} -u ${var.provision_username} site.yml"
        working_dir = "../../ansible"
    }
}

# proxmox_vm_qemu.pxe1:
resource "proxmox_vm_qemu" "pxe1" {
    lifecycle {
        ignore_changes = [
            # The packer generated templates contain a note with a timestamp
            # as to when the template was created.  Changed in this note can
            # be ignored.
            desc,
        ]
    }

    agent                  = 1
    balloon                = 0
    bios                   = "ovmf"
    boot                   = "order=scsi0;ide2;net0"
    clone                  = "debian12-minimal-blue"
    cores                  = 2
    cpu                    = "x86-64-v2-AES"
    define_connection_info = false
    force_create           = false
    full_clone             = false
    hotplug                = "network,disk,usb"
    vmid                   = "303"
    kvm                    = true
    memory                 = 2048
    name                   = "pxe1"
    numa                   = false
    onboot                 = true
    oncreate               = true
    qemu_os                = "l26"
    scsihw                 = "virtio-scsi-single"
    sockets                = 1
    tablet                 = true
    target_node            = "pve1-mgt"
    vcpus                  = 0

    disk {
        backup             = true
        cache              = "none"
        discard            = "on"
        file               = "303/vm-303-disk-1.qcow2"
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
        volume             = "truenas1:303/vm-303-disk-1.qcow2"
    }

    network {
        bridge    = "vmbr0"
        firewall  = true
        link_down = false
        macaddr   = "CA:FE:01:01:04:01"
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
        macaddr   = "CA:FE:01:01:04:02"
        model     = "virtio"
        mtu       = 0
        queues    = 0
        rate      = 0
        tag       = 10
    }

    provisioner "remote-exec" {
        inline = ["ip a"]

        connection {
            host        = self.name
            type        = "ssh"
            user        = var.provision_username
            agent       = true
        }
    }

    provisioner "local-exec" {
        command = "ansible-playbook -i inv.blue.yml -l ${self.name} -u ${var.provision_username} site.yml"
        working_dir = "../../ansible"
    }
}

# proxmox_vm_qemu.registry1:
resource "proxmox_vm_qemu" "registry1" {
    lifecycle {
        ignore_changes = [
            # The packer generated templates contain a note with a timestamp
            # as to when the template was created.  Changed in this note can
            # be ignored.
            desc,
        ]
    }

    agent                  = 1
    balloon                = 0
    bios                   = "ovmf"
    boot                   = "order=scsi0;ide2;net0"
    clone                  = "debian12-minimal-blue"
    cores                  = 2
    cpu                    = "x86-64-v2-AES"
    define_connection_info = false
    force_create           = false
    full_clone             = false
    hotplug                = "network,disk,usb"
    vmid                   = "304"
    kvm                    = true
    memory                 = 2048
    name                   = "registry1"
    numa                   = false
    onboot                 = true
    oncreate               = true
    qemu_os                = "l26"
    scsihw                 = "virtio-scsi-single"
    sockets                = 1
    tablet                 = true
    target_node            = "pve1-mgt"
    vcpus                  = 0

    disk {
        backup             = true
        cache              = "none"
        discard            = "on"
        file               = "304/vm-304-disk-1.qcow2"
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
        volume             = "truenas1:304/vm-304-disk-1.qcow2"
    }

    network {
        bridge    = "vmbr0"
        firewall  = true
        link_down = false
        macaddr   = "CA:FE:01:01:05:01"
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
        macaddr   = "CA:FE:01:01:05:02"
        model     = "virtio"
        mtu       = 0
        queues    = 0
        rate      = 0
        tag       = 10
    }

    provisioner "remote-exec" {
        inline = ["ip a"]

        connection {
            host        = self.name
            type        = "ssh"
            user        = var.provision_username
            agent       = true
        }
    }

    provisioner "local-exec" {
        command = "ansible-playbook -i inv.blue.yml -l ${self.name} -u ${var.provision_username} site.yml"
        working_dir = "../../ansible"
    }
}
