#!/bin/bash
packer validate \
    -var pm_api_url=$PM_API_URL \
    -var pm_api_token_id=$PM_API_TOKEN_ID \
    -var pm_api_token_secret=$PM_API_TOKEN_SECRET \
    -var username=$PROVISION_USER \
    -var gecos="$PROVISION_GECOS" \
    -var password='$PROVISION_PW' \
    -var iso_storage_pool=$PM_ISO_STORAGE_POOL \
    -var domain=$(dnsdomainname) \
    -var vm_id=$TPLT3_ID \
    -var pve_node="$TPLT3_NODE" \
    -var storage_pool=$TPLT3_STORAGE_POOL \
    -var vlan=$TPLT3_VLAN \
    -var vm_name=$TPLT3_NAME \
    -var install_file=$TPLT3_INSTALL_FILE \
    fedora38.pkr.hcl &&
packer build \
    -var pm_api_url=$PM_API_URL \
    -var pm_api_token_id=$PM_API_TOKEN_ID \
    -var pm_api_token_secret=$PM_API_TOKEN_SECRET \
    -var username=$PROVISION_USER \
    -var gecos="$PROVISION_GECOS" \
    -var password='$PROVISION_PW' \
    -var iso_storage_pool=$PM_ISO_STORAGE_POOL \
    -var domain=$(dnsdomainname) \
    -var vm_id=$TPLT3_ID \
    -var pve_node="$TPLT3_NODE" \
    -var storage_pool=$TPLT3_STORAGE_POOL \
    -var vlan=$TPLT3_VLAN \
    -var vm_name=$TPLT3_NAME \
    -var install_file=$TPLT3_INSTALL_FILE \
    fedora38.pkr.hcl
 packer validate \
    -var pm_api_url=$PM_API_URL \
    -var pm_api_token_id=$PM_API_TOKEN_ID \
    -var pm_api_token_secret=$PM_API_TOKEN_SECRET \
    -var username=$PROVISION_USER \
    -var gecos="$PROVISION_GECOS" \
    -var password='$PROVISION_PW' \
    -var iso_storage_pool=$PM_ISO_STORAGE_POOL \
    -var domain=$(dnsdomainname) \
    -var vm_id=$TPLT4_ID \
    -var pve_node="$TPLT4_NODE" \
    -var storage_pool=$TPLT4_STORAGE_POOL \
    -var vlan=$TPLT4_VLAN \
    -var vm_name=$TPLT4_NAME \
    -var install_file=$TPLT4_INSTALL_FILE \
    fedora38.pkr.hcl &&
 packer build \
    -var pm_api_url=$PM_API_URL \
    -var pm_api_token_id=$PM_API_TOKEN_ID \
    -var pm_api_token_secret=$PM_API_TOKEN_SECRET \
    -var username=$PROVISION_USER \
    -var gecos="$PROVISION_GECOS" \
    -var password='$PROVISION_PW' \
    -var iso_storage_pool=$PM_ISO_STORAGE_POOL \
    -var domain=$(dnsdomainname) \
    -var vm_id=$TPLT4_ID \
    -var pve_node="$TPLT4_NODE" \
    -var storage_pool=$TPLT4_STORAGE_POOL \
    -var vlan=$TPLT4_VLAN \
    -var vm_name=$TPLT4_NAME \
    -var install_file=$TPLT4_INSTALL_FILE \
    fedora38.pkr.hcl
