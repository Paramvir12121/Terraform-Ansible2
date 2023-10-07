# Terraform & Ansible Deployment on Azure

This repository contains configurations and scripts for deploying infrastructure on Azure using Terraform and configuring resources using Ansible. The deployment includes a variety of modules such as resource groups, networks, Linux/Windows VMs, load balancers, and databases.

## 📋 Table of Contents

- [Infrastructure Overview](#infrastructure-overview)
- [Ansible Roles](#ansible-roles)
- [Getting Started](#getting-started)
- [License](#license)

## 🌐 Infrastructure Overview

- **Resource Group Module**: Sets up a resource group in Azure.
- **Network Module**: Configures the virtual network, subnet, and network security group.
- **Common Module**: Contains configurations for common services like storage accounts, log analytics workspaces, and recovery services vault.
- **Linux & Windows VM Modules**: Deploys Linux and Windows virtual machines respectively.
- **Datadisk Module**: Manages data disks attached to the VMs.
- **LoadBalancer Module**: Sets up a load balancer for the Linux VMs.
- **Database Module**: Configures a PostgreSQL database.

All configurations can be found in the `main.tf` file with each module having its dedicated configurations.

## 🤖 Ansible Roles

The Ansible roles are designed to configure the resources post-deployment:

- **datadisk**: Creates partitions and mounts disks to VMs.
- **users**: Manages user creation on the deployed VMs.
- **webserver**: Sets up and configures an Apache web server.

Each role is structured according to Ansible best practices with tasks, handlers, files, and templates.

## 🚀 Getting Started

1. **Clone the Repository**

    ```bash
    git clone https://github.com/your-username/azure-terraform-ansible.git
    cd azure-terraform-ansible
    ```

2. **Initialize Terraform**

    ```bash
    terraform init
    ```

3. **Apply Terraform Configurations**

    ```bash
    terraform apply
    ```

4. **Run Ansible Playbook**

    ```bash
    ansible-playbook -i inventory.ini main-playbook.yml
    ```

Replace `inventory.ini` and `main-playbook.yml` with your specific inventory and playbook files if different.

## ⚖️ License

This project is under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

---

For more details or issues, please refer to the official Terraform, Ansible, and Azure documentation or raise an issue in this repository.
