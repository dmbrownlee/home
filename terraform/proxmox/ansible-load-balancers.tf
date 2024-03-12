resource "ansible_host" "load_balancers" {
  for_each = { for vm in var.vms : vm.hostname => vm if vm.role == "load_balancer" }
  name     = each.key
  groups   = ["load_balancers"]
  /* variables = { */
  /*   vrrp_instance_name = "lb1" */
  /*   vrrp_instance_state = "MASTER" */
  /*   vrrp_instance_priority = 100 */
  /*   vrrp_instance_router_id = 251 */
  /* } */
  depends_on = [
    resource.proxmox_virtual_environment_vm.load_balancers
  ]
}

resource "ansible_playbook" "load_balancers" {
  for_each                = { for vm in var.vms : vm.hostname => vm if vm.role == "load_balancer" }
  name                    = each.key
  playbook                = "ansible/load-balancers/playbook.yml"
  replayable              = true
  ignore_playbook_failure = true
  var_files = [
    "ansible/load-balancers/${each.key}_vrrp.yml"
  ]
  extra_vars = {
    private_key      = var.ssh_private_key_files[var.ciuser]
    ansible_ssh_user = var.ciuser
  }
  depends_on = [
    resource.ansible_host.load_balancers
  ]
}
