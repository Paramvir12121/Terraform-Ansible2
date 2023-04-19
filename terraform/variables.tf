locals {
  tags = {
    Name           = "Automation Project – Assignment 2"
    GroupMembers   = "Paramvir.Singh"
    ExpirationDate = "2023-06-30"
  Environment = "Lab" }
  prefix_name = "Paramvir9079"
  prefix_id   = "9079"
  location    = "eastus"
}



variable "vmlinux" {
  type = map(any)
  default = {
    name = "linux-9079-vm"
    avset = "linux-avset"
    size = "Standard_B1ms"
    count = 2
  }
  
}

variable "vmwindows" {
  type = map(any)
  default = {
    name = "win-9079"
    avset_name = "win-avset"
    size = "Standard_B1ms"
    }
}

