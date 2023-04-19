#!/bin/bash

# Get the ansible host IP addresses using terraform output command
ansible_host1=$(terraform output | grep Linux_public_ip_addresses1 | awk -F= '{gsub(/"/, "", $2); print $2}' | sed 's/^[[:space:]]*//')
ansible_host2=$(terraform output | grep Linux_public_ip_addresses2 | awk -F= '{gsub(/"/, "", $2); print $2}' | sed 's/^[[:space:]]*//')

# Create the hosts file
cat <<EOF > /home/ubuntu/automation/Terraform-Ansible2/ansible/inventory/hosts
[linux]
linux-9079-vm1 ansible_host=${ansible_host1} ansible_user=Paramvir9079
linux-9079-vm2 ansible_host=${ansible_host2} ansible_user=Paramvir9079

[os:children]
linux

[linux:vars]
ansible_connection=ssh
EOF

# Run the Ansible playbook
ansible-playbook /home/ubuntu/automation/Terraform-Ansible2/ansible/playbook/groupX-playbook.yaml
