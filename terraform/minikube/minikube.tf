variable "provision_username" {
    type = string
}

resource "proxmox_vm_qemu" "minikube1" {
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
    clone                  = "debian12-workstation-green"
    cores                  = 4
    cpu                    = "host"
    define_connection_info = false
    force_create           = false
    full_clone             = false
    hotplug                = "network,disk,usb"
    vmid                   = 600
    kvm                    = true
    memory                 = 16384
    name                   = "minikube1"
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
        file               = "600/vm-600-disk-1.qcow2"
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
        volume             = "truenas1:600/vm-600-disk-1.qcow2"
    }

    network {
        bridge    = "vmbr0"
        firewall  = true
        link_down = false
        macaddr   = "ca:fe:01:03:01:01"
        model     = "virtio"
        mtu       = 0
        queues    = 0
        rate      = 0
        tag       = 30
    }

    timeouts {}

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
    command = "ansible-playbook -i inv.minikube.yml -l ${self.name} -u ${var.provision_username} site.yml"
    working_dir = "../../ansible"
  }
}
