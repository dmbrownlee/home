mirror
=========

Configure debmirror and an Apache sight to serve up a repo for Debian
bookwork locally.

Requirements
------------

The role was build with the assumption the actual dataset is stored on a NAS
and automounted via autofs.  This enables you to tear down the machine and
rebuild it quickly without the ~15 hour wait for debmirror to complete its
first run.

This means the UID and GID of the account used should exist on the NAS and have
write access to the share.

Role Variables
--------------

Structure your site_data file like this:

```yaml
---
mirroradmin:
  groupname: mirrorgroup
  gid: 1234
  username: mirroruser
  uid: 1234
  gecos: Mirror Adminstrative Account
  home: /home/mirroruser
mirrors:
  mirror_root: /net/nfsserver/mirrorexport
  debian:
    src: ftp.us.debian.org
    path: "{{ mirror_root }}/debian"
```

Dependencies
------------

autofs (if you are automounting a network share as mentioned above).

Example Playbook
----------------

This might work.

    - hosts: mirrors
      vars_files:
        - site_data
      roles:
         - { role: dmbrownlee.mirror }

License
-------

TBD

Author Information
------------------

none
