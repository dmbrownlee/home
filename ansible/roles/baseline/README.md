baseline
=========

This role applies a Standard Operating Environment to a machine.  Besides installing a few common packages, it ensures openssh is installed and configured to start on boot and the root account's password is disabled.

Requirements
------------

None

Role Variables
--------------

None

Dependencies
------------

None

Example Playbook
----------------

- name: Apply Standard Operating Environment to the local host
  hosts: localhost
  roles:
    - { role: baseline }

License
-------

TBD

Author Information
------------------

https://github.com/dmbrownlee
