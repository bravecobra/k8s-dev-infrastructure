# K8S Dev Infrastructure

## Description

This repository contains a `kubernetes` dev infrastructure, providing both crosscutting concerns as well as Saas infrastructure. All this is provided through `terraform` deploying `helm` charts and custom configuration.

| Category        | Service                 | Description              |
| :-------------- | ----------------------- | ------------------------ |
| Networking      | traefik                 | Reverse Proxy            |
| Networking      | linkerd                 | Service Mesh             |
| Networking      | cert-manager            | Certificates             |
| Monitoring      | seq                     | Logging                  |
| Monitoring      | loki                    | Logging                  |
| Monitoring      | jaeger                  | Tracing                  |
| Monitoring      | tempo                   | Tracing                  |
| Monitoring      | prometheus              | Metrics                  |
| Monitoring      | metrics-server          | Metrics                  |
| Monitoring      | opentelemetry-collector | Ingestion                |
| Saas Cache      | redis                   | Caching                  |
| Saas Cloud      | localstack              | AWS emulator             |
| Saas Config     | etcd                    | Key-Value service        |
| Saas Config     | vault                   | Secrets management       |
| Saas Database   | mongodb                 | Document database        |
| Saas Database   | mariadb                 | Relational database      |
| Saas Database   | mysql                   | Relational database      |
| Saas Database   | oracle                  | Relational database      |
| Saas Database   | postgres                | Relational database      |
| Saas Database   | sqlserver               | Relational database      |
| Saas Deployment | fluxcd                  | GitOps                   |
| Saas Deployment | argocd                  | GitOps                   |
| Saas Messaging  | kafka                   | Messaging                |
| Saas Messaging  | rabbitmq                | Messaging                |
| Saas Search     | elasticsearch           | Search Engine            |
| Saas Auth       | identityserver          | IDP                      |
| Saas Auth       | keycloak                | IDP                      |
| Saas Storage    | minio                   | S3 compatible storage    |
| Saas Storage    | azurite                 | Azure compatible storage |

## Deploy

### Quick Start

- Install Tooling
  - Install Docker: [Docker desktop](https://www.docker.com/products/docker-desktop/) or [Rancher desktop](https://rancherdesktop.io/)
  - Install [Lens](https://k8slens.dev/) (K8S GUI)
  - Install tooling [prerequisites](./docs/preparation.md)
- Create a local `k8s` cluster
  - Edit your `hosts`: add domain names
  - Check the docker network subnet range (adjust in main.tf -> variable) so there is no overlap with an existing one.
  - Generate mkcert as admin
  - Run generate certificates.ps1
  - Creation local cluster
    - cluster k3d: terraform init + apply
    - cluster kind: terraform init + apply
- Deploy
  - edit `terraform.tfvars`
  - deploy services: terraform init + apply

### Documentation

The docs are available at [Github Pages](https://bravecobra.github.io/k8s-dev-infrastructure/)

#### Build the docs locally

```shell
pip install --user -f requirements.txt
mkdocs build
mkdocs serve
```
