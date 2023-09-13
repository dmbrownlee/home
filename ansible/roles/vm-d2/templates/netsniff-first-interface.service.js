[Unit]
Description=netsniff-ng FPC on {{ ansible_interfaces[0] }}

[Service]
#Environment= MY_ENVIRONMENT_VAR =/path/to/file.config
WorkingDirectory=/nsm/sensor_data/d2-{{ ansible_interfaces[0] }}
ExecStart=/usr/sbin/netsniff-ng -i {{ ansible_interfaces[0] }} -o dailylogs/ --user 1100 --group 1100 -s --prefix snort.log. --verbose -c --ring-size 64MiB --interval 150MiB
Restart=always

[Install]
WantedBy=multi-user.target
