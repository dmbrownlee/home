# proxmox_vm_qemu.k8s-cp-1:
resource "proxmox_vm_qemu" "k8s-cp-1" {
  name                   = "k8s-cp-1"
  clone                  = "debian12-minimal"
  target_node            = var.target_node
#  vmid                   = "110"
  agent                  = 1
  bios                   = "ovmf"
  boot                   = "order=scsi0;ide2;net0"
  cores                  = 4
  memory                 = 8192
  cpu                    = "x86-64-v2-AES"
  scsihw                 = "virtio-scsi-single"
  define_connection_info = false
  force_create           = false
  full_clone             = false
  hotplug                = "network,disk,usb"
  kvm                    = true
  numa                   = false
  onboot                 = true
  vm_state               = "running"
  qemu_os                = "l26"
  sockets                = 1
  tablet                 = true
  vcpus                  = 0

  network {
    bridge    = "vmbr0"
    firewall  = true
    link_down = false
    macaddr   = "BC:24:11:0D:85:94"
    model     = "virtio"
    mtu       = 0
    queues    = 0
    rate      = 0
    tag       = 30
  }

  smbios {
    uuid = "48215bbd-02d5-489c-9f1d-14e8641222e9"
  }
}

/* # proxmox_vm_qemu.k8s-cp-2: */
/* resource "proxmox_vm_qemu" "k8s-cp-2" { */
/*     agent                  = 1 */
/*     balloon                = 0 */
/*     bios                   = "ovmf" */
/*     boot                   = "order=scsi0;ide2;net0" */
/*     cores                  = 4 */
/*     cpu                    = "x86-64-v2-AES" */
/*     define_connection_info = false */
/*     force_create           = false */
/*     full_clone             = false */
/*     hotplug                = "network,disk,usb" */
/*     vmid                   = "111" */
/*     kvm                    = true */
/*     memory                 = 8192 */
/*     name                   = "k8s-cp-2" */
/*     numa                   = false */
/*     onboot                 = true */
/*     vm_state               = "running" */
/*     qemu_os                = "l26" */
/*     scsihw                 = "virtio-scsi-single" */
/*     sockets                = 1 */
/*     tablet                 = true */
/*     target_node            = "pve1-mgt" */
/*     vcpus                  = 0 */

/*     network { */
/*         bridge    = "vmbr0" */
/*         firewall  = true */
/*         link_down = false */
/*         macaddr   = "BC:24:11:86:EF:C9" */
/*         model     = "virtio" */
/*         mtu       = 0 */
/*         queues    = 0 */
/*         rate      = 0 */
/*         tag       = 30 */
/*     } */

/*     smbios { */
/*         uuid = "1ae29e68-d4ff-4172-8e99-b5bf9f0b92eb" */
/*     } */
/* } */

/* # proxmox_vm_qemu.k8s-cp-3: */
/* resource "proxmox_vm_qemu" "k8s-cp-3" { */
/*     agent                  = 1 */
/*     balloon                = 0 */
/*     bios                   = "ovmf" */
/*     boot                   = "order=scsi0;ide2;net0" */
/*     cores                  = 4 */
/*     cpu                    = "x86-64-v2-AES" */
/*     define_connection_info = false */
/*     force_create           = false */
/*     full_clone             = false */
/*     hotplug                = "network,disk,usb" */
/*     vmid                   = "112" */
/*     kvm                    = true */
/*     memory                 = 8192 */
/*     name                   = "k8s-cp-3" */
/*     numa                   = false */
/*     onboot                 = true */
/*     vm_state               = "running" */
/*     qemu_os                = "l26" */
/*     scsihw                 = "virtio-scsi-single" */
/*     sockets                = 1 */
/*     tablet                 = true */
/*     target_node            = "pve1-mgt" */
/*     vcpus                  = 0 */

/*     network { */
/*         bridge    = "vmbr0" */
/*         firewall  = true */
/*         link_down = false */
/*         macaddr   = "BC:24:11:E8:7F:9C" */
/*         model     = "virtio" */
/*         mtu       = 0 */
/*         queues    = 0 */
/*         rate      = 0 */
/*         tag       = 30 */
/*     } */

/*     smbios { */
/*         uuid = "70687441-d7b2-44cb-b49b-a331a230f50d" */
/*     } */
/* } */

/* # proxmox_vm_qemu.k8s-worker-1: */
/* resource "proxmox_vm_qemu" "k8s-worker-1" { */
/*     agent                  = 1 */
/*     balloon                = 0 */
/*     bios                   = "ovmf" */
/*     boot                   = "order=scsi0;ide2;net0" */
/*     cores                  = 4 */
/*     cpu                    = "x86-64-v2-AES" */
/*     define_connection_info = false */
/*     force_create           = false */
/*     full_clone             = false */
/*     hotplug                = "network,disk,usb" */
/*     vmid                   = "113" */
/*     kvm                    = true */
/*     memory                 = 8192 */
/*     name                   = "k8s-worker-1" */
/*     numa                   = false */
/*     onboot                 = true */
/*     vm_state               = "running" */
/*     qemu_os                = "l26" */
/*     scsihw                 = "virtio-scsi-single" */
/*     sockets                = 1 */
/*     tablet                 = true */
/*     target_node            = "pve1-mgt" */
/*     vcpus                  = 0 */

/*     network { */
/*         bridge    = "vmbr0" */
/*         firewall  = true */
/*         link_down = false */
/*         macaddr   = "BC:24:11:86:68:CD" */
/*         model     = "virtio" */
/*         mtu       = 0 */
/*         queues    = 0 */
/*         rate      = 0 */
/*         tag       = 30 */
/*     } */

/*     smbios { */
/*         uuid = "47fb3b77-2219-4388-92a5-e8602a6c6e21" */
/*     } */
/* } */

/* # proxmox_vm_qemu.k8s-worker-2: */
/* resource "proxmox_vm_qemu" "k8s-worker-2" { */
/*     agent                  = 1 */
/*     balloon                = 0 */
/*     bios                   = "ovmf" */
/*     boot                   = "order=scsi0;ide2;net0" */
/*     cores                  = 4 */
/*     cpu                    = "x86-64-v2-AES" */
/*     define_connection_info = false */
/*     force_create           = false */
/*     full_clone             = false */
/*     hotplug                = "network,disk,usb" */
/*     vmid                   = "114" */
/*     kvm                    = true */
/*     memory                 = 8192 */
/*     name                   = "k8s-worker-2" */
/*     numa                   = false */
/*     onboot                 = true */
/*     vm_state               = "running" */
/*     qemu_os                = "l26" */
/*     scsihw                 = "virtio-scsi-single" */
/*     sockets                = 1 */
/*     tablet                 = true */
/*     target_node            = "pve1-mgt" */
/*     vcpus                  = 0 */

/*     network { */
/*         bridge    = "vmbr0" */
/*         firewall  = true */
/*         link_down = false */
/*         macaddr   = "BC:24:11:DD:87:3D" */
/*         model     = "virtio" */
/*         mtu       = 0 */
/*         queues    = 0 */
/*         rate      = 0 */
/*         tag       = 30 */
/*     } */

/*     smbios { */
/*         uuid = "c0705782-43b2-4e36-a22f-9da3eaf39a83" */
/*     } */
/* } */
