# Resource Group Module
module "resource_group" {
  source      = "./modules/rgroup"
  rgroup_name = "9079-Assignment2-RG"
  location    = local.location
  tags        = local.tags
}

# Network Module
module "network" {
  source       = "./modules/network"
  rgroup_name  = module.resource_group.rgroup_name
  location     = module.resource_group.location
  vnet_name    = "vnet-production"
  vnet_space   = "10.0.0.0/16"
  subnet_name  = "subnet-1"
  subnet_space = "10.0.1.0/24"
  nsg_name     = "nsg-1"
  tags         = module.resource_group.tags
}

#Common Module
module "common" {
  source          = "./modules/common"
  location        = module.resource_group.location
  rgroup_name     = module.resource_group.rgroup_name
  storage_account = "storageaccountparamvir"
  container_name  = "tfstatefiles"
  la_workspace = {
    law_name  = "laworkspaceparamvir9079"
    log_sku   = "PerGB2018"
    retention = 30
  }
  rs_vault = {
    vault_name = "rsvaultparamvir9079"
    vault_sku  = "Standard"
  }
  tags = local.tags
}

# Linux Module
module "linux" {
  source                = "./modules/vmlinux"
  rgroup_name           = module.resource_group.rgroup_name
  location              = module.resource_group.location
  vmlinux_name          = var.vmlinux.name
  vmlinux_avset         = var.vmlinux.avset
  size                  = var.vmlinux.size
  nb_count              = var.vmlinux.count
  subnet_id             = module.network.subnet1_id
  tags                  = module.resource_group.tags
  primary_blob_endpoint = module.common.primary_blob_endpoint
  ansible_path = "//wsl.localhost/Ubuntu/home/paramvir/automation/ansible/assignment"
  ansible_playbook = "groupX-playbook.yaml"
}

# Windows Module
module "windows" {
  source                = "./modules/vmwindows"
  rgroup_name           = module.resource_group.rgroup_name
  location              = module.resource_group.location
  vmwindows_name        = var.vmwindows.name
  vmwindows_avset       = var.vmwindows.avset_name
  size                  = var.vmwindows.size
  subnet_id             = module.network.subnet1_id
  tags                  = module.resource_group.tags
  primary_blob_endpoint = module.common.primary_blob_endpoint
}

# Datadisk Module
module "datadisk" {
  source         = "./modules/datadisk"
  rgroup_name    = module.resource_group.rgroup_name
  location       = module.resource_group.location
  vmwindows_name = module.windows.Windows_hostname
  vmwindows_id   = module.windows.Windows_vm.id
  tags           = module.resource_group.tags
  vmlinux_name = {
    lvm-9079-vm-1 = 0
    lvm-9079-vm-2 = 1
  }
  vmlinux_id = [module.linux.Linux_id]
}

# LoadBalancer Module
module "loadbalancer" {
  source      = "./modules/loadbalancer"
  rgroup_name = module.resource_group.rgroup_name
  location    = module.resource_group.location
  tags        = module.resource_group.tags
  vmlinux_name = {
    lvm-9079-vm-1 = 0
    lvm-9079-vm-2 = 1
  }
  vmlinux_network_interface_id = [module.linux.Linux_network_interface_id]
  vmlinux_pip_id               = module.linux.Linux_public_ip_addresses_id

}

# Database Module
module "database" {
  source           = "./modules/database"
  rgroup_name      = module.resource_group.rgroup_name
  location         = module.resource_group.location
  psql_server_name = "postgresql-server-9079"
  psql_db_name     = "database-9079"
  tags             = module.resource_group.tags
}