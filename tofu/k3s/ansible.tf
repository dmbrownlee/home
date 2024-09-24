###############################################################################
###############################################################################
##
##  Variable Definitions
##
###############################################################################
###############################################################################
variable "k3s_token" {
  description = "Join token for K3S (any string)"
  type        = string
}

variable "k3s_version" {
  description = "Version of K3S to install"
  type        = string
}

variable "k3s_api_url" {
  description = "Version of K3S to install"
  type        = string
}

variable "k3s_local_kubeconfig_path" {
  description = "Path to kubeconfig on the Ansible controller"
  type        = string
}

variable "k3s_vip_ip" {
  description = "Floating virtual IP of the external loadbalancer"
  type        = string
}

variable "k3s_vip_hostname" {
  description = "Hostname associated with the floating VIP"
  type        = string
}

variable "k3s_vip_domain" {
  description = "The site domain"
  type        = string
}

variable "k3s_nfs_server" {
  description = "The hostname of the NFS server providing persistent storage"
  type        = string
}

variable "k3s_nfs_path" {
  description = "The path to NFS persistent storage"
  type        = string
}

variable "want_k3s_longhorn" {
  type    = bool
  default = false
}


resource "ansible_host" "k3s_initial_cp" {
  for_each = { for vm in var.vms : vm.hostname => vm if vm.role == "k3s_initial_cp" }
  name     = each.key
  groups   = ["k3s_initial_cp"]
  depends_on = [
    resource.proxmox_virtual_environment_vm.k3s_initial_cp
  ]
}


###############################################################################
###############################################################################
##
##  Resource Definitions
##
###############################################################################
###############################################################################
resource "ansible_group" "k3s_initial_cp" {
  name     = "k3s_initial_cp"
  children = [for vm in var.vms : vm.hostname if vm.role == "k3s_initial_cp"]
  depends_on = [
    resource.proxmox_virtual_environment_vm.k3s_initial_cp
  ]
}

resource "ansible_playbook" "k3s_initial_cp" {
  for_each                = { for vm in var.vms : vm.hostname => vm if vm.role == "k3s_initial_cp" }
  playbook                = "ansible/playbook.yml"
  name                    = each.key
  replayable              = var.ansible_replayable
  groups                  = ["k3s_initial_cp"]
  ignore_playbook_failure = true
  extra_vars = {
    private_key               = var.ssh_private_key_files[var.ci_user]
    ansible_ssh_user          = var.ci_user
    k3s_token                 = var.k3s_token
    k3s_version               = var.k3s_version
    k3s_api_url               = var.k3s_api_url
    k3s_role                  = each.value.role
    k3s_local_kubeconfig_path = var.k3s_local_kubeconfig_path
    k3s_vip_ip                = var.k3s_vip_ip
    k3s_vip_hostname          = var.k3s_vip_hostname
    k3s_vip_domain            = var.k3s_vip_domain
    tofu_workspace            = "${terraform.workspace}"
  }
  depends_on = [
    resource.ansible_host.k3s_initial_cp,
  ]
}

output "playbook_output_k3s_initial_cp" {
  value = var.want_ansible_output ? ansible_playbook.k3s_initial_cp : null
}


###############################################################################
##
##  Additional K3S control plane nodes (k3s servers)
##
###############################################################################
resource "ansible_host" "k3s_servers" {
  for_each = { for vm in var.vms : vm.hostname => vm if var.want_k3s_servers && vm.role == "k3s_server" }
  name     = each.key
  groups   = ["k3s_servers"]
  depends_on = [
    resource.proxmox_virtual_environment_vm.k3s_servers
  ]
}

resource "ansible_group" "k3s_servers" {
  name     = "k3s_servers"
  children = [for vm in var.vms : vm.hostname if var.want_k3s_servers && vm.role == "k3s_server"]
  depends_on = [
    resource.proxmox_virtual_environment_vm.k3s_servers
  ]
}

resource "ansible_playbook" "k3s_servers" {
  for_each                = { for vm in var.vms : vm.hostname => vm if var.want_k3s_servers && vm.role == "k3s_server" }
  playbook                = "ansible/playbook.yml"
  name                    = each.key
  replayable              = var.ansible_replayable
  groups                  = ["k3s_servers"]
  ignore_playbook_failure = true
  extra_vars = {
    private_key      = var.ssh_private_key_files[var.ci_user]
    ansible_ssh_user = var.ci_user
    k3s_token        = var.k3s_token
    k3s_version      = var.k3s_version
    k3s_api_url      = var.k3s_api_url
    k3s_role         = each.value.role
    k3s_vip_ip       = var.k3s_vip_ip
    k3s_vip_hostname = var.k3s_vip_hostname
    k3s_vip_domain   = var.k3s_vip_domain
    tofu_workspace            = "${terraform.workspace}"
  }
  depends_on = [
    resource.ansible_host.k3s_servers,
    resource.ansible_playbook.k3s_initial_cp,
  ]
}

output "playbook_output_k3s_servers" {
  value = var.want_ansible_output && var.want_k3s_servers ? ansible_playbook.k3s_servers : null
}


###############################################################################
##
##  Additional K3S worker nodes (k3s agents)
##
###############################################################################
resource "ansible_host" "k3s_agents" {
  for_each = { for vm in var.vms : vm.hostname => vm if var.want_k3s_agents && vm.role == "k3s_agent" }
  name     = each.key
  groups   = ["k3s_agent"]
  depends_on = [
    resource.proxmox_virtual_environment_vm.k3s_agents
  ]
}

resource "ansible_group" "k3s_agents" {
  name     = "k3s_agents"
  children = [for vm in var.vms : vm.hostname if var.want_k3s_agents && vm.role == "k3s_agent"]
  depends_on = [
    resource.proxmox_virtual_environment_vm.k3s_agents
  ]
}

resource "ansible_playbook" "k3s_agents" {
  for_each                = { for vm in var.vms : vm.hostname => vm if var.want_k3s_agents && vm.role == "k3s_agent" }
  playbook                = "ansible/playbook.yml"
  name                    = each.key
  replayable              = var.ansible_replayable
  groups                  = ["k3s_agents"]
  ignore_playbook_failure = true
  extra_vars = {
    private_key      = var.ssh_private_key_files[var.ci_user]
    ansible_ssh_user = var.ci_user
    k3s_token        = var.k3s_token
    k3s_version      = var.k3s_version
    k3s_api_url      = var.k3s_api_url
    k3s_role         = each.value.role
    k3s_vip_ip       = var.k3s_vip_ip
    k3s_vip_hostname = var.k3s_vip_hostname
    k3s_vip_domain   = var.k3s_vip_domain
    tofu_workspace            = "${terraform.workspace}"
  }
  depends_on = [
    resource.ansible_host.k3s_agents,
    resource.ansible_playbook.k3s_servers,
  ]
}

output "playbook_output_k3s_agents" {
  value = var.want_ansible_output && var.want_k3s_agents ? ansible_playbook.k3s_agents : null
}


###############################################################################
##
##  NFS storage provisioner
##
###############################################################################
resource "ansible_playbook" "k3s_nfs" {
  playbook                = "ansible/playbook-nfs.yml"
  name                    = "localhost"
  replayable              = var.ansible_replayable
  ignore_playbook_failure = true
  extra_vars = {
    ansible_hostname          = "localhost"
    ansible_connection        = "local"
    private_key               = var.ssh_private_key_files[var.ci_user]
    ansible_ssh_user          = var.ci_user
    k3s_local_kubeconfig_path = var.k3s_local_kubeconfig_path
    tofu_workspace            = "${terraform.workspace}"
    persistent_nfs_server     = var.k3s_nfs_server
    persistent_nfs_path       = var.k3s_nfs_path
  }
  depends_on = [
    resource.ansible_playbook.k3s_initial_cp,
    resource.ansible_playbook.k3s_servers,
    resource.ansible_playbook.k3s_agents,
  ]
}

output "playbook_output_k3s_nfs" {
  value = var.want_ansible_output ? ansible_playbook.k3s_nfs : null
}


###############################################################################
##
##  Longhorn storage provisioner
##
###############################################################################
resource "ansible_playbook" "k3s_longhorn" {
  count                   = var.want_k3s_longhorn ? 1 : 0
  playbook                = "ansible/playbook-longhorn.yml"
  name                    = "localhost"
  replayable              = var.ansible_replayable
  ignore_playbook_failure = true
  extra_vars = {
    ansible_hostname          = "localhost"
    ansible_connection        = "local"
    private_key               = var.ssh_private_key_files[var.ci_user]
    ansible_ssh_user          = var.ci_user
    k3s_local_kubeconfig_path = var.k3s_local_kubeconfig_path
    tofu_workspace            = "${terraform.workspace}"
  }
  depends_on = [
    resource.ansible_playbook.k3s_initial_cp,
    resource.ansible_playbook.k3s_servers,
    resource.ansible_playbook.k3s_agents,
  ]
}

output "playbook_output_k3s_longhorn" {
  value = var.want_ansible_output ? ansible_playbook.k3s_longhorn : null
}


###############################################################################
##
##  Prometheus service monitoring and alerting
##
###############################################################################
resource "ansible_playbook" "k3s_prometheus" {
  playbook                = "ansible/playbook-prometheus.yml"
  name                    = "localhost"
  replayable              = var.ansible_replayable
  ignore_playbook_failure = true
  extra_vars = {
    ansible_hostname          = "localhost"
    ansible_connection        = "local"
    private_key               = var.ssh_private_key_files[var.ci_user]
    ansible_ssh_user          = var.ci_user
    k3s_local_kubeconfig_path = var.k3s_local_kubeconfig_path
    tofu_workspace            = "${terraform.workspace}"
  }
  depends_on = [
    resource.ansible_playbook.k3s_longhorn,
  ]
}

output "playbook_output_k3s_prometheus" {
  value = var.want_ansible_output ? ansible_playbook.k3s_prometheus : null
}


###############################################################################
##
##  Grafana data visualization
##
###############################################################################
resource "ansible_playbook" "k3s_grafana" {
  playbook                = "ansible/playbook-grafana.yml"
  name                    = "localhost"
  replayable              = var.ansible_replayable
  ignore_playbook_failure = true
  extra_vars = {
    ansible_hostname          = "localhost"
    ansible_connection        = "local"
    private_key               = var.ssh_private_key_files[var.ci_user]
    ansible_ssh_user          = var.ci_user
    k3s_local_kubeconfig_path = var.k3s_local_kubeconfig_path
    tofu_workspace            = "${terraform.workspace}"
  }
  depends_on = [
    resource.ansible_playbook.k3s_longhorn,
  ]
}

output "playbook_output_k3s_grafana" {
  value = var.want_ansible_output ? ansible_playbook.k3s_grafana : null
}


###############################################################################
##
##  cert-manager TLS certificate management
##
###############################################################################
resource "ansible_playbook" "k3s_certmanager" {
  playbook                = "ansible/playbook-certmanager.yml"
  name                    = "localhost"
  replayable              = var.ansible_replayable
  ignore_playbook_failure = true
  extra_vars = {
    ansible_hostname          = "localhost"
    ansible_connection        = "local"
    private_key               = var.ssh_private_key_files[var.ci_user]
    ansible_ssh_user          = var.ci_user
    k3s_local_kubeconfig_path = var.k3s_local_kubeconfig_path
    tofu_workspace            = "${terraform.workspace}"
  }
  depends_on = [
    resource.ansible_playbook.k3s_longhorn,
  ]
}

output "playbook_output_k3s_certmanager" {
  value = var.want_ansible_output ? ansible_playbook.k3s_certmanager : null
}
