resource "ansible_host" "k8s_workers" {
  for_each = { for vm in var.vms: vm.hostname => vm if vm.role == "k8s_worker" }
  name        = each.key
  groups = ["worker_nodes"]
  depends_on = [
    resource.proxmox_virtual_environment_vm.k8s_workers
  ]
}

resource "ansible_playbook" "k8s_workers" {
  for_each = { for vm in var.vms: vm.hostname => vm if vm.role == "k8s_worker" }
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
