netbox
=========

A brief description of the role goes here.

Requirements
------------


Role Variables
--------------
This role expects you to define these variables in ~/.site_data:

---
netbox:
  hostname: YOUR_NETBOX_SERVERS_FQDN
  secret_key: "YOUR_NETBOX_SECRET_KEY"
  app:
    username: YOUR_NETBOX_ADMIN_ACCOUNT
    password: "YOUR_NETBOX_ADMIN_PASSWORD"
  postgresql:
    database: YOUR_NETBOX_DATABASE_NAME
    username: YOUR_NETBOX_DATABASE_OWNER
    password: "YOUR_NETBOX_DATABASE_OWNER_PASSWORD"
  system:
    username: YOUR_NETBOX_SYSTEM_ACCOUNT
  example_config:
    # current checksum for /opt/netbox/netbox/netbox/configuration_example.py
    checksum: "786889efca4913058cb194fd85b52b3177481093"


Dependencies
------------
Using this role:
  roles:
    - dmbrownlee.postgresql

Using molecule to test the role (in addition to above):

  collections:
    - containers.podman


Example Playbook
----------------

This might work.

    - hosts: all
      roles:
         - { role: dmbrownlee.netbox }

License
-------

TBD

Author Information
------------------

none
