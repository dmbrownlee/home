# The home repo
This repo contains Ansible playbooks to automate setting up machines on my home network.

## ```local.yml```
This is the default playbook for ansible-pull which is used to configure the local machine.  By scheduling ansible-pull to run periodically, such as from cron, a system can use this playbook to keep itself configured while it is running.

## ```pull.yml```
This playbook configures the local system to periodically run ansible-pull.  This is intended to be run once either manually or from the post section of a kickstart file.
