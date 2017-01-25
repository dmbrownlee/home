default menu.c32
prompt 0
timeout 300
ONTIMEOUT local
menu title ########## PXE Boot Menu ##########
label 1
menu label ^1) Install CentOS 7 x64 using Local Repo
kernel centos7/vmlinuz
append initrd=centos7/initrd.img method=ftp://{{ ansible_default_ipv4.address }}/pub devfs=nomount
label 2
menu label ^2) Install CentOS 7 x64 using http://mirror.centos.org Repo
kernel centos7/vmlinuz
append initrd=centos7/initrd.img method=http://mirror.centos.org/centos/7/os/x86_64/ devfs=nomount ip=dhcp
label 3
menu label ^3) Install d2.home.test
kernel centos7/vmlinuz
append initrd=centos7/initrd.img method=ftp://{{ ansible_default_ipv4.address }}/pub devfs=nomount init.ks=https://raw.githubusercontent.com/dmbrownlee/home.test/master/d2-ks.cfg
label 4
menu label ^4) Boot from local drive
