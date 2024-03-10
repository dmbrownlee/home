resource "ansible_host" "load_balancers" {
  for_each    = toset([ for n in var.load_balancers: n.hostname ])
  name        = each.key
  groups = ["load_balancers"]
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

/* resource "ansible_host" "lb1" { */
/*   name        = "lb1" */
/*   groups = ["load_balancers"] */
/*   variables = { */
/*     vrrp_instance_name = "lb1" */
/*     vrrp_instance_state = "MASTER" */
/*     vrrp_instance_priority = 100 */
/*     vrrp_instance_router_id = 251 */
/*   } */
/*   depends_on = [ */
/*     resource.proxmox_virtual_environment_vm.lb1 */
/*   ] */
/* } */

resource "ansible_playbook" "load_balancers" {
  for_each    = toset([ for n in var.load_balancers: n.hostname ])
  name       = each.key
  playbook   = "ansible/load-balancers/playbook.yml"
  replayable = true
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

/* resource "ansible_playbook" "lb1" { */
/*   playbook   = "lb-playbook.yml" */
/*   name       = "lb1" */
/*   replayable = true */
/*   ignore_playbook_failure = true */
/*   var_files = [ */
/*     "lb1_vrrp.yml" */
/*   ] */
/*   extra_vars = { */
/*     private_key      = var.ssh_private_keys[var.ciuser] */
/*     ansible_ssh_user = var.ciuser */
/*   } */
/*   depends_on = [ */
/*     resource.ansible_host.lb1 */
/*   ] */
/* } */

/* output "lb1_playbook_output" { */
/*   value = ansible_playbook.lb1 */
/* } */

/* output "lb2_playbook_output" { */
/*   value = ansible_playbook.lb2 */
/* } */