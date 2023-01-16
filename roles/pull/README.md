pull
=========

The ```pull``` role configures a machine to configure itself by using ```ansible-pull``` periodically.  Specifically, this was written for use in the ```%post``` post section of a Fedora kickstart file.  It also configures public key authentication for the ansible user so you can push your plays as well.  However, it does not install openssh-server or start it.

Requirements
------------

The local machine is assumed to be running Fedora Linux.

Role Variables
--------------

None

Dependencies
------------

None

Example Playbook
----------------

By default, ```ansible-pull``` looks for ```local.yml``` in the root off your git repo.  Therefore, the ```%post``` section of your kickstart file might look like:

```bash
# fedora-ks.cfg
%post --log=/root/ks-post.log
# the ansible-pull command requires git
dnf install -y ansible-core git-core

# These variables should be passed on the kernel command line when starting
# the installer:
#
# kspost.fqdn:
#   The fully qualified name of the host you are installing.  If set, the
#   hostname will be updated to this before ansible runs (so ansible will use
#   this instead of localhost).
# kspost.ansible_vault_password_file:
#   URL to the ansible vault password file.  It is assumed this URL is only
#   accessible from the provisioning network.
FQDN=""
VPWURL=""

for o in `cat /proc/cmdline`; do
  case $o in
    kspost.fqdn=*)
      FQDN=${o#*=}
      ;;
    kspost.ansible_vault_password_file=*)
      VPWURL=${o#*=}
      ;;
  esac
done

if [ -n "$FQDN" ]; then
  # Set the hostname before running ansible-pull
  echo $FQDN > /etc/hostname
  /usr/bin/hostname --file /etc/hostname
fi

if [ -n "$VPWURL" ]; then
  # Fetch the ansible-vault password file from the URL and run ansible-pull
  CONFIG_USER=ansible
  CONFIG_USER_HOME=/home/$CONFIG_USER
  VAULT_PASSWORD_FILE=$CONFIG_USER_HOME/.vaultpw
  curl -o $VAULT_PASSWORD_FILE $VPWURL
  chown $CONFIG_USER:$CONFIG_USER $VAULT_PASSWORD_FILE
  chmod 600 $VAULT_PASSWORD_FILE
  ansible-pull --vault-password-file $VAULT_PASSWORD_FILE -U https://github.com/jdoe/somerepo.git
fi

%end
```

The contents of ```local.yml``` would look like:
```yaml
- name: Configure host to pull its configuration using ansible-pull
  hosts: localhost
  roles:
    - { role: pull }
  when: ansible_distribution == "Fedora"
```

You could also create a playbook to run this manually on hosts that have already been installed.  That might look like:
```yaml
# register.yml
- name: Configure hosts to pull their configuration using ansible-pull
  hosts: all
  roles:
    - { role: dmbrownlee.pull }
  when: ansible_distribution == "Fedora"
```

License
-------

TBD

Author Information
------------------

https://github.com/dmbrownlee
