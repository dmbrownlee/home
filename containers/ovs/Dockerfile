FROM alpine:latest

RUN apk add --no-cache sudo runit bash python3 bash-completion openvswitch openvswitch-bash-completion

COPY --chown=root:root files/boot.sh /sbin/boot.sh
COPY --chown=root:root files/ovsdb-server-log.runit /etc/sv/ovsdb-server/log/run
COPY --chown=root:root files/ovsdb-server.runit /etc/sv/ovsdb-server/run
COPY --chown=root:root files/ovs-vswitchd-log.runit /etc/sv/ovs-vswitchd/log/run
COPY --chown=root:root files/ovs-vswitchd.runit /etc/sv/ovs-vswitchd/run

RUN mkdir -p /var/run/openvswitch \
&& ovsdb-tool create /etc/openvswitch/conf.db /usr/share/openvswitch/vswitch.ovsschema \
&& ovsdb-server --detach --remote=punix:/var/run/openvswitch/db.sock \
&& ovs-vswitchd --detach \
&& ovs-vsctl --no-wait init \
&& ovs-vsctl add-br br0 \
&& ovs-vsctl set bridge br0 datapath_type=netdev \
&& mkdir -p /var/log/svlogd/ovsdb-server \
&& mkdir -p /var/log/svlogd/ovs-vswitchd \
&& mkdir -p /etc/sv/ovsdb-server/log \
&& mkdir -p /etc/sv/ovs-vswitchd/log \
&& mv /etc/profile.d/color_prompt.sh.disabled /etc/profile.d/color_prompt.sh \
&& ln -s /usr/share/bash-completion/completions/ovs-vsctl-bashcomp.bash /etc/profile.d/ovs-vsctl.sh \
&& ln -s /usr/share/bash-completion/completions/ovs-appctl-bashcomp.bash /etc/profile.d/ovs-appctl.sh \
&& chmod 755 /sbin/boot.sh /etc/sv/ovsdb-server/run /etc/sv/ovsdb-server/log/run /etc/sv/ovs-vswitchd/run /etc/sv/ovs-vswitchd/log/run \
&& ln -s /etc/sv/ovsdb-server /etc/service/ovsdb-server \
&& ln -s /etc/sv/ovs-vswitchd /etc/service/ovs-vswitchd \
&& sed -i -e '/^root:/s/ash/bash/' /etc/passwd

CMD ["/sbin/boot.sh"]
