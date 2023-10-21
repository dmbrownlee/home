# Configuration
Create `$HOME/.bashrc.d/packer` and set this environment variable as appropriate for your environment.

> [!note] Values shown here are only examples.

> [!note] The $PM_... variables are set elsewhere.

```shell
export PROVISION_USER=someuser
export PROVISION_GECOS="Some User"
export PROVISION_PW=somepw
export PM_ISO_STORAGE_POOL='local-lvm'

# First template is a minimal install
export TPLT1_ID=900                             # An unused Proxmox ID
export TPLT1_NODE="pve1-mgt"                    # Which Proxmox node to use
export TPLT1_STORAGE_POOL='local-lvm'
export TPLT1_VLAN=100
export TPLT1_NAME=debian12-uefi-minimal         # VM/template name
export TPLT1_INSTALL_FILE=minimal-uefi.preseed       # VM/template name

# Second template is for workstations with a GUI
export TPLT2_ID=901                             # An unused Proxmox ID
export TPLT2_NODE="pve1-mgt"                    # Which Proxmox node to use
export TPLT2_STORAGE_POOL='local-lvm'
export TPLT2_VLAN=100
export TPLT2_NAME=debian12-uefi-workstation     # VM/template name
export TPLT2_INSTALL_FILE=workstation-uefi.preseed   # VM/template name
```

After exec'ing a new shell, you'll be able to use the `build.sh` script.
