A playground for playing with infratructure services on Linux.

=== d1.home.test vagrant target
My workstation is d1.home.test.  It is installed using boot media and a
kickstart file hosted on GitHub.  This VM is used to test changes to the
installation process.  Vagrant is only used to create the virtual hardware
which means:

1. The base box specified doesn't matter as we will install an OS over it.
2. We also don't need the provisioners so just start it with:
   vagrant up --no-provision d1.home.test

After the virtual hardware has been created, shutdown the VM, "insert" the
ISO image, and install as you would on the physical machine.

=== Installing using the kickstart file on GitHub

1. Boot the VM or physical machine from the CentOS Everything ISO/DVD
2. At the installation menu, press [tab] to append to the kernel boot line
3. Add "inst.ks=https://raw.githubusercontent.com/dmbrownlee/home.test/master/ks-d1.cfg" and press [enter].

