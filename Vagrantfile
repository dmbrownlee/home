# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.ssh.private_key_path= "../keys/vagrant"
  config.ssh.pty = true
  # Common to all VMs
  config.vm.box = "CentOS-7-x86_64-Everything-1511"
  config.vm.boot_timeout = 60
  config.vm.synced_folder ".", "/vagrant", disabled: false

  config.vm.provision :ansible do |ansible|
    ansible.playbook = "ansible/playbook.yml"
  end

  # Note: 192.168.56.200 is the virtualbox host's adapter

  # .1 is a nice traditional value for a nameserver
  config.vm.define "pc-192.168.56.1" do |node|
    node.vm.hostname = "dns1"
    node.vm.network "private_network", ip: "192.168.56.1"
    node.vm.provider "virtualbox" do |vb|
      vb.name = "pc-192.168.56.1"
    end
  end

  # Workstation for testing network services
  config.vm.define "pc-192.168.56.100" do |node|
    node.vm.hostname = "workstation"
    node.vm.network "private_network", ip: "192.168.56.100"
    node.vm.provider "virtualbox" do |vb|
      vb.name = "pc-192.168.56.100"
    end
  end

  # Default Gateway (NAT Firewall)
  config.vm.define "pc-192.168.56.254" do |node|
    node.vm.hostname = "defaultgw"
    node.vm.network "private_network", ip: "192.168.56.254"
    node.vm.provider "virtualbox" do |vb|
      vb.name = "pc-192.168.56.254"
    end
  end
end
