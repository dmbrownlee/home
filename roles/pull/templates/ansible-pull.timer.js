[Unit]
Description=Periodic configuration management sync
Documentation=man:ansible-pull(1)

[Timer]
OnCalendar=hourly
OnBootSec=5m
AccuracySec=5m
Persistent=true

[Install]
WantedBy=timers.target
