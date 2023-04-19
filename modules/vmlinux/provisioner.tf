# resource "null_resource" "linux_provisioner" {
#   count      = var.nb_count
#   depends_on = [azurerm_linux_virtual_machine.linux-vm]

#   provisioner "remote-exec" {
#     inline = ["mkdir file1"]
#     connection {
#       type     = "ssh"
#       user     = var.admin_username
#       password = var.admin_password
#       host     = element(azurerm_linux_virtual_machine.linux-vm[*].public_ip_address, count.index + 1)
#     }
#   }
# }

resource "null_resource" "ansible-configuration" {
  depends_on = [azurerm_linux_virtual_machine.linux-vm]
  provisioner "local-exec" {
    working_dir = "${var.ansible_path}"
    interpreter = ["wsl", "-Command"]
    command = "./terraform/create_hosts.sh"
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

# }



