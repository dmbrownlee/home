#==========================================
# Variables for communicating with Proxmox
#==========================================
variable "pm_api_url" {
  type = string
}
variable "pm_api_token_secret" {
  type = string
}
variable "pm_api_token_id" {
  type = string
}


#==========================================
# Variables specific to site
#==========================================
variable "vm_name" {
  type    = string
  default = "debian12-uefi-minimal"
}
variable "vm_id" {
  type = string
}
variable "domain" {
  type = string
}
variable "pve_node" {
  type = string
}
variable "storage_pool" {
  type = string
}
variable "iso_storage_pool" {
  type = string
}
variable "vlan" {
  type = string
}


#==========================================
# Variables describing VM hardware
#==========================================
variable "cores" {
  type    = string
  default = "2"
}
variable "disk_size" {
  type    = string
  default = "20G"
}
variable "memory" {
  type    = string
  default = "2048"
}


#==========================================
# Variables for the provisioning account
#==========================================
variable "username" {
  type = string
}
variable "gecos" {
  type = string
}
variable "password" {
  type = string
}
variable "keydir" {
  type = string
}

#==========================================
# Variables for the automated install
#==========================================
variable "install_file" {
  type    = string
  default = "minimal-uefi.preseed"
}
variable "country" {
  type    = string
  default = "US"
}
variable "keyboard" {
  type    = string
  default = "us"
}
variable "language" {
  type    = string
  default = "en"
}
variable "locale" {
  type    = string
  default = "en_US.UTF-8"
}
variable "mirror" {
  type    = string
  default = "ftp.us.debian.org"
}
variable "system_clock_in_utc" {
  type    = string
  default = "true"
}
variable "timezone" {
  type    = string
  default = "UTC"
}
variable "http_port_max" {
  type    = string
  default = "9000"
}
variable "http_port_min" {
  type    = string
  default = "8000"
}
variable "start_retry_timeout" {
  type    = string
  default = "5m"
}


source "proxmox-iso" "vyos-livecd" {
  boot_command = [
    "vyos<enter>",
    "<wait2>vyos<enter>",
    "<wait10>install image<enter>",
    "<wait2>Yes<enter>",
    "<wait5>Auto<enter>",
    "<wait2>sda<enter>",
    "<wait2>Yes<enter>",
    "<wait2><enter>",     # default root size
    "<wait10><enter>",    # default image name
    "<wait60>"
    #"<wait5><enter>",     # default config boot
    /* "<wait2>vyos<enter>", # default password for vyos   dies here */
    /* "<wait2>vyos<enter>", # again */
    /* "<wait2>sda<enter>",  # where to install grub */
    /* "<wait60>reboot<enter>" */
  ]
  boot_wait   = "60s"
  cores       = "${var.cores}"
  cpu_type    = "x86-64-v2-AES"
  disable_kvm = false
  disks {
    disk_size    = "${var.disk_size}"
    io_thread    = true
    storage_pool = "${var.storage_pool}"
    type         = "scsi"
  }
  efi_config {
    efi_storage_pool  = "${var.storage_pool}"
    efi_type          = "4m"
    pre_enrolled_keys = true
  }
  iso_file                 = "${var.iso_storage_pool}:iso/vyos-1.5-rolling-202310090023-amd64.iso"
  insecure_skip_tls_verify = true
  machine                  = "pc"
  memory                   = "${var.memory}"
  network_adapters {
    bridge   = "vmbr0"
    model    = "virtio"
    vlan_tag = "${var.vlan}"
  }
  network_adapters {
    bridge = "vmbr0"
    model  = "virtio"
  }
  network_adapters {
    bridge = "vmbr0"
    model  = "virtio"
  }
  network_adapters {
    bridge = "vmbr0"
    model  = "virtio"
  }
  node                 = "${var.pve_node}"
  os                   = "l26"
  onboot               = false
  proxmox_url          = "${var.pm_api_url}"
  scsi_controller      = "virtio-scsi-single"
  sockets              = 1
  ssh_password         = "${var.password}"
  ssh_timeout          = "120m"
  ssh_username         = "${var.username}"
  template_description = "Debian 12 (${var.install_file}), generated on ${timestamp()}"
  template_name        = "${var.vm_name}"
  token                = "${var.pm_api_token_secret}"
  unmount_iso          = true
  username             = "${var.pm_api_token_id}"
  vga {
    type   = "qxl"
    memory = 32
  }
  vm_id   = "${var.vm_id}"
  vm_name = "${var.vm_name}"
}

build {
  sources = ["source.proxmox-iso.vyos-livecd"]

  /* provisioner "shell" { */
  /*   binary              = false */
  /*   execute_command     = "echo '${var.password}' | {{ .Vars }} sudo -E -S '{{ .Path }}'" */
  /*   expect_disconnect   = true */
  /*   inline              = [ */
  /*     "echo '${var.username} ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/99${var.username}", */
  /*     "chmod 0440 /etc/sudoers.d/99${var.username}", */
  /*     "echo 'auto ens18\niface ens18 inet dhcp\n' > /etc/network/interfaces.d/ens18", */
  /*     "mkdir -p /home/${var.username}/.ssh/", */
  /*     "chown -R ${var.username}:${var.username} /home/${var.username}/.ssh/" */
  /*   ] */
  /*   inline_shebang      = "/bin/sh -e" */
  /*   skip_clean          = false */
  /*   start_retry_timeout = "${var.start_retry_timeout}" */
  /* } */

  /* provisioner "file" { */
  /*   source      = "${var.keydir}/${var.username}.pub" */
  /*   destination = "/home/${var.username}/.ssh/authorized_keys2" */
  /* } */

  /* provisioner "shell" { */
  /*   binary              = false */
  /*   execute_command     = "echo '${var.password}' | {{ .Vars }} sudo -E -S '{{ .Path }}'" */
  /*   expect_disconnect   = true */
  /*   inline              = ["apt-get update", "apt-get --yes dist-upgrade", "apt-get clean"] */
  /*   inline_shebang      = "/bin/sh -e" */
  /*   skip_clean          = false */
  /*   start_retry_timeout = "${var.start_retry_timeout}" */
  /* } */
}
