#!/bin/bash
/sbin/runsvdir -P /etc/service &

# Give runit a chance to start the ovsdb-server
while [ ! -S /var/run/openvswitch/db.sock ]; do
  sleep 1
done

# Counting interfaces is zero-indexed so the number of the last interface is
# one less than the total number of ports.
LASTIF=$((${NUMPORTS:-8} - 1))
for i in $(seq 0 $LASTIF); do
  ovs-vsctl add-port br0 eth$i
done

if [ -n "$BRIDGE_CONTROLLER" ]; then
  ovs-vsctl set-controller br0 $BRIDGE_CONTROLLER
else
  ip addr add ${BRIDGEIP:-192.168.0.1/24} dev br0
  ip link set dev br0 up
fi

while true; do
  /bin/bash -l
done
