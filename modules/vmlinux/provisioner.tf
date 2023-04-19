resource "null_resource" "linux_provisioner" {
  count      = var.nb_count
  depends_on = [azurerm_linux_virtual_machine.linux-vm]

  provisioner "remote-exec" {
    inline = ["mkdir file1"]
    connection {
      type     = "ssh"
      user     = var.admin_username
      password = var.admin_password
      host     = element(azurerm_linux_virtual_machine.linux-vm[*].public_ip_address, count.index + 1)
    }
  }
}



resource "null_resource" "ansible-configuration" {
  count      = var.nb_count
  depends_on = [azurerm_linux_virtual_machine.linux-vm]
  provisioner "local-exec" {
    working_dir = "${var.ansible_path}"
    interpreter = ["Bash", "-Command"]
    command = <<-EOT
      echo "[linux]" > inventory/hosts &&
      echo "linux-9079-vm1 ansible_host=${element(azurerm_linux_virtual_machine.linux-vm.*.public_ip_address, count.index)} ansible_user=Paramvir9079" >> inventory/hosts &&
      echo "[os:children]" >> inventory/hosts &&
      echo "linux" >>inventory/hosts &&
      echo "[linux:vars]" >>inventory/hosts &&
      echo "ansible_connection=ssh" >> inventory/hosts &&
      ansible-playbook -i inventory/hosts playbook/groupX-playbook.yaml
    EOT
  }
}



