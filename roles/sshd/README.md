sshd
=========

Apply a standard configuration to sshd.

Requirements
------------

Existing users should had their SSH public key uplodaed to the authorized_keys
file as this config change will disable the use of passwords for remote login.

Role Variables
--------------
None.

Dependencies
------------

None.

Example Playbook
----------------

This might work.

    - hosts: all
      vars_files:
        - site_data
      roles:
         - { role: dmbrownlee.sshd }

License
-------

TBD

Author Information
------------------

none
