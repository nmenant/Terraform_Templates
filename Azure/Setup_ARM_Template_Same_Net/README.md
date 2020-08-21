Setup Ressource Group to consume ARM Template
=============================================

This folder contain a Terraform template to deploy the following:

* 1 Resource Group with 3 subnets: mgmt, public, private

This can be used to deploy an F5 ARM template: https://github.com/F5Networks/f5-azure-arm-templates/tree/master/supported/failover/same-net/via-api/n-nic/existing-stack/payg

Deployment
----------

* do *terraform init* / *terraform get* / *terraform plan* / *terraform apply* to deploy your infrastructure
* *terraform output* will give you the relevant public IPs related to your infrastructure.
