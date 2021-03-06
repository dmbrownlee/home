 MENU TITLE Specific System Installs Menu
 
LABEL d2
  MENU LABEL ^Install d2.home.test
  kernel centos7/vmlinuz
  append initrd=centos7/initrd.img inst.repo=ftp://{{ ansible_default_ipv4.address }}/pub/centos7 devfs=nomount inst.ks=https://raw.githubusercontent.com/dmbrownlee/home.test/master/d2-ks.cfg ip=dhcp net.ifnames=0

LABEL d2b
  MENU LABEL ^Install d2.home.test (d2-ks.cfg from local FTP server)
  kernel centos7/vmlinuz
  append initrd=centos7/initrd.img inst.repo=ftp://{{ ansible_default_ipv4.address }}/pub/centos7 devfs=nomount inst.ks=ftp://{{ ansible_default_ipv4.address }}/pub/d2-ks.cfg ip=dhcp net.ifnames=0

LABEL MainMenu
  MENU LABEL ^Return to Main Menu
  KERNEL menu.c32
  APPEND pxelinux.cfg/default
