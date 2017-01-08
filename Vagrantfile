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

  # VM for testing kickstart installs for the d1 host
  config.vm.define "d1.home.test" do |node|
    node.vm.box = "CentOS-7-x86_64-minimal-1511"
    node.vm.hostname = "d1.host.test"
    node.vm.provider "virtualbox" do |vb|
      vb.name = "d1.home.test"
      vb.memory = 8192
      vb.cpus = 2
      vb.gui = true
      vb.customize ["modifyvm", :id, "--ostype", "RedHat_64"]
      vb.customize ["modifyvm", :id, "--accelerate3d", "on"]
      vb.customize ["modifyvm", :id, "--vrde", "off"]
      vb.customize ["modifyvm", :id, "--vram", 16]
      # Detach the hdd created by Vagrant from the IDE controller
      vb.customize ["storageattach", :id, "--storagectl", "IDE Controller", "--port", 0, "--device", 0, "--medium", "none"]
      # Add a DVD drive to the IDE controller (do NOT insert disk)
      # and change boot order to boot from the ISO image.
      vb.customize ["storageattach", :id, "--storagectl", "IDE Controller", "--port", 0, "--device", 0, "--type", "dvddrive", "--medium", "emptydrive"]
      #vb.customize ["storageattach", :id, "--storagectl", "IDE Controller", "--port", 0, "--device", 0, "--type", "dvddrive", "--medium", "/Users/dmb/Downloads/CentOS-7-x86_64-Everything-1511.iso"]
      vb.customize ["modifyvm", :id, "--boot1", "dvd"]
      vb.customize ["modifyvm", :id, "--boot2", "disk"]
      # Add a SATA controller and reattach default disk to it
      begin
        vb.customize ["storagectl", :id, "--name", "SATA Controller", "--add", "sata"]
        rescue   => e
        puts e
        puts e.message
      end
      vb.customize ["storageattach", :id, "--storagectl", "SATA Controller", "--port", 0, "--device", 0, "--type", "hdd", "--medium", "/Users/dmb/VirtualBox VMs/d1.home.test/CentOS-7-x86_64-Minimal-1511-disk1.vmdk"]
      # Create and attach two more drives to mimic the drives in the
      # physical workstation
      vb.customize ["createmedium", "disk", "--filename", "/Users/dmb/VirtualBox VMs/d1.home.test/CentOS-7-x86_64-Minimal-1511-disk2.vmdk", "--size", 40000, "--format", "VMDK"]
      vb.customize ["storageattach", :id, "--storagectl", "SATA Controller", "--port", 1, "--device", 0, "--type", "hdd", "--medium", "/Users/dmb/VirtualBox VMs/d1.home.test/CentOS-7-x86_64-Minimal-1511-disk2.vmdk"]
      vb.customize ["createmedium", "disk", "--filename", "/Users/dmb/VirtualBox VMs/d1.home.test/CentOS-7-x86_64-Minimal-1511-disk3.vmdk", "--size", 40000, "--format", "VMDK"]
      vb.customize ["storageattach", :id, "--storagectl", "SATA Controller", "--port", 2, "--device", 0, "--type", "hdd", "--medium", "/Users/dmb/VirtualBox VMs/d1.home.test/CentOS-7-x86_64-Minimal-1511-disk3.vmdk"]
    end
  end
end
