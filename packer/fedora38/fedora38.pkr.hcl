#==========================================
# Variables for communicating with Proxmox
#==========================================
variable "pm_api_url" {
  type    = string
}
variable "pm_api_token_secret" {
  type    = string
}
variable "pm_api_token_id" {
  type    = string
}


#==========================================
# Variables specific to site
#==========================================
variable "vm_name" {
  type    = string
  default = "fedora38-minimal"
}
variable "vm_id" {
  type    = string
}
variable "domain" {
  type    = string
}
variable "pve_node" {
  type    = string
}
variable "storage_pool" {
  type    = string
}
variable "iso_storage_pool" {
  type    = string
}
variable "vlan" {
  type    = string
}
variable "luks_initial_password" {
  type    = string
  default = ""
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
  type    = string
}
variable "gecos" {
  type    = string
}
variable "password" {
  type    = string
}
variable "keydir" {
  type    = string
}


#==========================================
# Variables for the automated install
#==========================================
variable "install_file" {
  type    = string
  default = "minimal-ks.cfg"
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


source "proxmox-iso" "fedora38-kickstart" {
  bios         = "ovmf"
  boot_command = [
    "<up>e<down><down><leftCtrlOn>e<leftCtrlOff><bs><bs><bs><bs><bs>",
    " text",
    " inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/${var.install_file}",
    " kspost.fqdn=${var.vm_name}",
    " kspost.ansible_vault_password_file=http://{{ .HTTPIP }}:{{ .HTTPPort }}/vaultpw",
    " kspost.ansible_branch=main",
    "<wait><wait><wait><wait>",
    "<leftCtrlOn>x"
  ]
  boot_wait    = "30s"
  cores        = "${var.cores}"
  cpu_type     = "x86-64-v2-AES"
  disable_kvm  = false
  disks {
    disk_size         = "${var.disk_size}"
    io_thread         = true
    storage_pool      = "${var.storage_pool}"
    type              = "scsi"
  }
  efi_config {
    efi_storage_pool  = "${var.storage_pool}"
    efi_type          = "4m"
    pre_enrolled_keys = true
  }
  http_content         = { "/${var.install_file}" = templatefile(var.install_file, { var = var }) }
  http_port_max        = var.http_port_max
  http_port_min        = var.http_port_min
  insecure_skip_tls_verify = true
  iso_file                 = "${var.iso_storage_pool}:iso/Fedora-Server-netinst-x86_64-38-1.6.iso"
  machine                  = "pc"
  memory                   = "${var.memory}"
  network_adapters {
    bridge = "vmbr0"
    model  = "virtio"
    vlan_tag = "${var.vlan}"
    firewall = true
    mac_address = "repeatable"
  }
  node                 = "${var.pve_node}"
  os                   = "l26"
  onboot               = false
  proxmox_url          = "${var.pm_api_url}"
  qemu_agent           = true
  scsi_controller      = "virtio-scsi-single"
  sockets              = 1
  ssh_password         = "${var.password}"
  ssh_timeout          = "60m"
  ssh_username         = "${var.username}"
  template_description = "Fedora 38 (${var.install_file}), generated on ${timestamp()}"
  template_name        = "${var.vm_name}"
  token                = "${var.pm_api_token_secret}"
  unmount_iso          = true
  username             = "${var.pm_api_token_id}"
  vga {
    type = "qxl"
    memory = 32
  }
  vm_id                = "${var.vm_id}"
  vm_name              = "${var.vm_name}"
}

build {
  sources = ["source.proxmox-iso.fedora38-kickstart"]

  provisioner "shell" {
    binary              = false
    execute_command     = "echo '${var.password}' | {{ .Vars }} sudo -E -S '{{ .Path }}'"
    expect_disconnect   = true
    inline              = [
      "echo '${var.username} ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/99${var.username}",
      "chmod 0440 /etc/sudoers.d/99${var.username}",
      "mkdir -p /home/${var.username}/.ssh/",
      "chown -R ${var.username}:${var.username} /home/${var.username}/.ssh/"
    ]
    inline_shebang      = "/bin/sh -e"
    skip_clean          = false
    start_retry_timeout = "${var.start_retry_timeout}"
  }

  provisioner "file" {
    source      = "${var.keydir}/${var.username}.pub"
    destination = "/home/${var.username}/.ssh/authorized_keys2"
  }

  provisioner "shell" {
    binary              = false
    execute_command     = "echo '${var.password}' | {{ .Vars }} sudo -E -S '{{ .Path }}'"
    expect_disconnect   = true
    inline              = ["dnf update -y", "dnf upgrade -y", "dnf autoremove -y"]
    inline_shebang      = "/bin/sh -e"
    skip_clean          = false
    start_retry_timeout = "${var.start_retry_timeout}"
  }
}
