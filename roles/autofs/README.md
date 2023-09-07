autofs
=========

Configures installs and starts autofs.

Requirements
------------

Fedora or Debian Linux

Role Variables
--------------

none

Dependencies
------------

none

Example Playbook
----------------

This might work.

    - hosts: nfsclients
      vars_files:
        - site_data
      roles:
         - { role: dmbrownlee.autofs }

License
-------

TBD

Author Information
------------------

none
