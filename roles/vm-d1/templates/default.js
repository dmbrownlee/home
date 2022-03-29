DEFAULT menu.c32
PROMPT 0

TIMEOUT 300
TOTALTIMEOUT 3000
ONTIMEOUT local

MENU TITLE PXE Boot Main Menu
MENU INCLUDE pxelinux.cfg/graphics.conf
MENU AUTOBOOT Booting from local system in # seconds

LABEL 1
  MENU LABEL ^Specific System Installs Menu
  KERNEL menu.c32
  APPEND pxelinux.cfg/graphics.conf pxelinux.cfg/kickstart.menu

LABEL 2
  MENU LABEL ^Install CentOS 7 x64 using Local Repo
  kernel centos7/vmlinuz
  append initrd=centos7/initrd.img inst.repo=ftp://{{ ansible_default_ipv4.address }}/pub/centos7 devfs=nomount

LABEL 3
  MENU LABEL ^Install CentOS 7 x64 using http://mirror.centos.org Repo
  kernel centos7/vmlinuz
  append initrd=centos7/initrd.img inst.repo=http://mirror.centos.org/centos/7/os/x86_64/ devfs=nomount ip=dhcp

LABEL 4
  MENU LABEL ^Boot from local system
