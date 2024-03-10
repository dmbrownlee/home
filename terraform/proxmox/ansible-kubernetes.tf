resource "ansible_host" "k8s_control_plane" {
  for_each    = toset([ for n in var.control_plane_nodes: n.hostname ])
  name        = each.key
  groups = ["control_plane_nodes"]
  depends_on = [
    resource.proxmox_virtual_environment_vm.k8s_control_plane
  ]
}

resource "ansible_host" "k8s_workers" {
  for_each    = toset([ for n in var.worker_nodes: n.hostname ])
  name        = each.key
  groups = ["worker_nodes"]
  depends_on = [
    resource.proxmox_virtual_environment_vm.k8s_workers
  ]
}

resource "ansible_playbook" "k8s_control_plane" {
  for_each    = toset([ for n in var.control_plane_nodes: n.hostname ])
  playbook   = "ansible/kubernetes/playbook.yml"
  name       = each.key
  replayable = true
  ignore_playbook_failure = true
  extra_vars = {
    private_key      = var.ssh_private_key_files[var.ciuser]
    ansible_ssh_user = var.ciuser
  }
  depends_on = [
    resource.ansible_host.k8s_control_plane
  ]
}

resource "ansible_playbook" "k8s_workers" {
  for_each    = toset([ for n in var.worker_nodes: n.hostname ])
  playbook   = "ansible/kubernetes/playbook.yml"
  name       = each.key
  replayable = true
  ignore_playbook_failure = true
  extra_vars = {
    private_key      = var.ssh_private_key_files[var.ciuser]
    ansible_ssh_user = var.ciuser
  }
  depends_on = [
    resource.ansible_host.k8s_workers,
    resource.ansible_playbook.k8s_control_plane
  ]
}

output "k8s_control_plane_playbook_output" {
  value = ansible_playbook.k8s_control_plane
}

output "k8s_workers_playbook_output" {
  value = ansible_playbook.k8s_workers
}
