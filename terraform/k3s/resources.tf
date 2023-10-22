module "k3s_servers" {
  source        = "git@github.com:dmbrownlee/proxmox-cloud-init.git"
  count         = var.server_count
  pm_api_url          = var.pm_api_url
  pm_api_token_secret = var.pm_api_token_secret
  pm_api_token_id     = var.pm_api_token_id
  hostname      = "k3s-server-${count.index + 1}"
  cloud_image   = var.cloud_image
  target_node   = var.target_node
  storage       = var.storage
  vlan          = var.vlan
  ciuser        = var.ciuser
  cipassword    = var.cipassword
  ssh_pubkey_file = "~/keys/${var.ciuser}.pub"
  ssh_privkey_file = "~/keys/${var.ciuser}"
  ip            = cidrhost(var.network, var.first_ip + count.index)
  ipconfig0     = "gw=${var.gateway},ip=${cidrhost(var.network, var.first_ip + count.index)}/${split("/",var.network)[1]}"
  searchdomain  = var.searchdomain
  nameserver    = var.nameserver
}

module "k3s_agents" {
  source        = "git@github.com:dmbrownlee/proxmox-cloud-init.git"
  count         = var.agent_count
  pm_api_url          = var.pm_api_url
  pm_api_token_secret = var.pm_api_token_secret
  pm_api_token_id     = var.pm_api_token_id
  hostname      = "k3s-agent-${count.index + 1}"
  cloud_image   = var.cloud_image
  target_node   = var.target_node
  storage       = var.storage
  vlan          = var.vlan
  ciuser        = var.ciuser
  cipassword    = var.cipassword
  ssh_pubkey_file = "~/keys/${var.ciuser}.pub"
  ssh_privkey_file = "~/keys/${var.ciuser}"
  ip            = cidrhost(var.network, var.first_ip + var.server_count + count.index)
  ipconfig0     = "gw=${var.gateway},ip=${cidrhost(var.network, var.first_ip + var.server_count + count.index)}/${split("/",var.network)[1]}"
  searchdomain  = var.searchdomain
  nameserver    = var.nameserver
}

output "k3s_servers" {
  value     = module.k3s_servers[*].vm
}

output "k3s_agents" {
  value     = module.k3s_agents[*].vm
}
