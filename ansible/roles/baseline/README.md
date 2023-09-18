baseline
=========

This role applies a Standard Operating Environment to a machine.  Besides installing a few common packages, it ensures openssh is installed and configured to start on boot and the root account's password is disabled.

Requirements
------------


Role Variables
--------------


Dependencies
------------


Example Playbook
----------------

This might work.

    - hosts: all
      roles:
         - { role: dmbrownlee.baseline }

License
-------

TBD

Author Information
------------------

none
