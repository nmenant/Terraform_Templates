Terraform and Ansible deployment templates
==========================================

This repo contains some generic templates to deploy systems using Terraform and Ansible.

Terraform is used to deploy the systems while Ansible will take care of the configuration of those systems.

Remarks - Terraform
-------------------

* make sure that your AWS credentials are set on your system using Terraform / Ansible (.aws/credentials for example on mac)
* update terraform/terraform.tfvars to deploy the infrastructure components acordingly (specifically the AllowedIPs to allow access from your public IP to your env). If you want more customization, you may check terraform/variables.tf 
* update terraform/templates/ansible_inventory.tpl file so that you specify the right ansible_python_interpreter for your local environment 
* do *terraform init* / *terraform get* / *terraform plan* / *terraform apply* to deploy your infrastructure
* *terraform output* will give you the relevant public IPs related to your infrastructure.

