# WARNING!  This system uses NetworkManger and settings in this file
#           may not reflect reality.  Use the following to verify settings:
#
#           nmcli c show {{ this_interface }}
#
NAME="{{ this_interface }}
DEVICE="{{ this_interface }}
ONBOOT=no
NETBOOT=no
IPV6INIT=no
BOOTPROTO=none
TYPE=Ethernet
DEFROUTE=no
ZONE=public
