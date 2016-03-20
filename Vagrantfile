# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.ssh.private_key_path= "../keys/vagrant"
  # Common to all VMs
  config.vm.box = "ubuntu-15.10-server-amd64"
  config.vm.boot_timeout = 60
  config.vm.synced_folder ".", "/vagrant", disabled: true

  config.vm.provision :ansible do |ansible|
    ansible.playbook = "ansible/playbook.yml"
  end

  # PC on the first network
  config.vm.define "pc-192.168.47.10" do |node|
    node.vm.hostname = "player1"
    node.vm.network "private_network", ip: "192.168.47.10"
    node.vm.provider "virtualbox" do |vb|
      vb.name = "pc-192.168.47.10"
    end
  end
end
