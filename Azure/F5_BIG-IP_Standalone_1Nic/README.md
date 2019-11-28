Terraform and Ansible deployment templates
==========================================

This repo contains some generic templates to deploy systems using Terraform and Ansible.

Terraform is used to deploy the systems while Ansible will take care of the configuration of those systems.

Remarks - Terraform
-------------------

* make sure that your Azure credentials are set on your system (env variables): <https://docs.microsoft.com/en-us/azure/virtual-machines/linux/terraform-install-configure>
* update terraform/terraform.tfvars to deploy the infrastructure components acordingly (specifically the AllowedIPs to allow access from your public IP to your env). If you want more customization, you may check terraform/variables.tf 
* do *terraform init* / *terraform get* / *terraform plan* / *terraform apply* to deploy your infrastructure
* *terraform output* will give you the relevant public IPs related to your infrastructure.

Remarks - Ansible
-----------------

* ansible/inventory/hosts will be created automatically by Terraform. *vs_ip* in the hosts file is the PRIVATE IP of your BIG-IP.
* playbooks/group_vars/F5_systems/vars will list your ubuntu PRIVATE IPs (variable LIST_AS3_POOL_SERVERS). This is created automatically by Terraform
* Update ansible/playbooks/group_vars/all file with the location of your private key
* You MUST create a file called f5_vault in ansible/playbooks/group_vars/F5_systems. You need to create this file yourself to store the admin password that will be used on your BIG-IP. The corresponding variables name to setup is: VAULT_ADMIN_PASSWORD. Example of f5_vault file: 

```yaml

    ---

    VAULT_ADMIN_PASSWORD: "myF5Password!"


```

* Once it's done, encrypt the file with the command *ansible-vault encrypt ansible/playbooks/group_vars/F5_systems/vault*
* update your ansible roles accordingly
* You can run *ansible-playbook -i inventory/hosts site.yml --ask-vault-pass*
