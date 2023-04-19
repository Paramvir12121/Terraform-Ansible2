
#  depends_on = [azurerm_linux_virtual_machine.linux-vm]
resource "null_resource" "run_script" {
depends_on = [azurerm_linux_virtual_machine.linux-vm]  
provisioner "local-exec" {
    command = "cd /home/ubuntu/automation/Terraform-Ansible2 && ./create_hosts.sh"
  }
}


#   provisioner "remote-exec" {
#     inline = ["/usr/bin/hostname"]
#     connection {
#       type     = "ssh"
#       user     = var.admin_username
#       password = var.admin_password
#       host     = element(azurerm_public_ip.linux-pip[*].fqdn, count.index + 1)
#     }
#   }

#}
