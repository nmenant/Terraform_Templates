# F5 Deployment with Terraform  in AWS

Here you will have access to different deployment leveraging Ansible and Terraform.

the *terraform_module* directory contains modules that are re-used between the different deployment: vpc creation, deploy F5 BIG-IP standalone, deploy ubuntu, ...

Make sure that your AWS credentials are set on your system using Terraform / Ansible (.aws/credentials for example on mac)