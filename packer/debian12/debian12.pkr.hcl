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
  default = "debian12-uefi-minimal"
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


#==========================================
# Variables for the automated install
#==========================================
variable "preseed_file" {
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


source "proxmox-iso" "debian12-preseed" {
  bios         = "ovmf"
  boot_command = [
    "<wait><wait><wait>c<wait><wait><wait>",
    "linux /install.amd/vmlinuz ",
    "auto=true ",
    "url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/${var.preseed_file} ",
    "hostname=${var.vm_name} ",
    "domain=${var.domain} ",
    "interface=auto ",
    "vga=788 noprompt quiet --<enter>",
    "initrd /install.amd/initrd.gz<enter>",
    "boot<enter>"
  ]
  boot_wait    = "20s"
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
  http_content         = { "/${var.preseed_file}" = templatefile(var.preseed_file, { var = var }) }
  http_port_max        = var.http_port_max
  http_port_min        = var.http_port_min
  insecure_skip_tls_verify = true
  iso_file                 = "${var.iso_storage_pool}:iso/debian-12.0.0-amd64-netinst.iso"
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
  ssh_timeout          = "25m"
  ssh_username         = "${var.username}"
  template_description = "Debian 12 (${var.preseed_file}), generated on ${timestamp()}"
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
  sources = ["source.proxmox-iso.debian12-preseed"]

  provisioner "shell" {
    binary              = false
    execute_command     = "echo '${var.password}' | {{ .Vars }} sudo -E -S '{{ .Path }}'"
    expect_disconnect   = true
    inline              = ["echo '${var.username} ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/99${var.username}", "chmod 0440 /etc/sudoers.d/99${var.username}"]
    inline_shebang      = "/bin/sh -e"
    skip_clean          = false
    start_retry_timeout = "${var.start_retry_timeout}"
  }

  provisioner "shell" {
    binary              = false
    execute_command     = "echo '${var.password}' | {{ .Vars }} sudo -E -S '{{ .Path }}'"
    expect_disconnect   = true
    inline              = ["apt-get update", "apt-get --yes dist-upgrade", "apt-get clean"]
    inline_shebang      = "/bin/sh -e"
    skip_clean          = false
    start_retry_timeout = "${var.start_retry_timeout}"
  }
}
