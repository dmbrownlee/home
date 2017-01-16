interface={{ ansible_default_ipv4.interface }}
#bind-interfaces
domain={{ ansible_domain }}
# DHCP range-leases
dhcp-range= {{ ansible_default_ipv4.interface }},192.168.42.100,192.168.42.199,{{ ansible_default_ipv4.broadcast }},1h
# PXE
dhcp-boot=pxelinux.0,pxeserver,{{ ansible_default_ipv4.address }}
# Gateway
dhcp-option=3,{{ ansible_default_ipv4.gateway }}
# DNS
dhcp-option=6,{{ ansible_dns.nameservers[0] }}, 8.8.8.8
server=8.8.4.4
# Broadcast Address
dhcp-option=28,{{ ansible_default_ipv4.address }}55
# NTP Server
#dhcp-option=42,0.0.0.0
pxe-prompt="Press F8 for menu.", 60
pxe-service=x86PC, "Install CentOS 7 from network server {{ ansible_default_ipv4.address }}", pxelinux
enable-tftp
tftp-root=/var/lib/tftpboot
