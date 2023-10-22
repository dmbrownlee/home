# K3S Cluster
This project uses Proxmox virtual machine templates based on Debian cloud-init images from https://cloud.debian.org/images/cloud/.

## Create the Debian12 cloud-init virtual machine template
1. Create a VM for your Debian install
1. Remove the hard disk
1. From the shell of the Proxmox node containing your VM, download the cloud-init image and attach it to your VM:
    ```shell
    wget https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-genericcloud-amd64.qcow2
    qm disk import 100 debian-12-genericcloud-amd64.qcow2 local-lvm
    ```
1. Convert the VM to a template
  > [!waring] Do NOT boot the VM before converting it to a template!  You do not want cloud-init to perform first boot configuration until AFTER you clone from the template.

## Running Terraform
The Proxmox provider for Terraform throws errors when it cannot acquire a lock when cloneing your VM templates so remember to run Terraform on one resource at a time:
```shell
terraform apply -parallelism=1
```
