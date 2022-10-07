# Quick Start

- Install docker desktop/rancher-desktop
- Install Lens
- install terraform
- Install [prerequisites](./preparation/cli.md)
- edit hosts: add domain name
- check docker network subnet range (adjust in main.tf -> variable)
- cluster k3d terraform init + apply
- generate mkcert as admin
- run generate certificates.ps1
- edit terraform.tfvars
- deploy services: terraform init + apply
