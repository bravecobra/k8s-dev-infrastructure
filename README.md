# K8S Dev Infrastructure

## Description

This repository contains a local `kubernetes` dev infrastructure.

It uses `Infrastructure as Code` using `terraform` to easily deploy a desired configuration onto the cluster, providing:

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
| Saas Messaging  | rabbitmq                | Message Broker           |
| Saas Search     | elasticsearch           | Search Engine            |
| Saas Auth       | identityserver          | IDP                      |
| Saas Auth       | keycloak                | IDP                      |
| Saas Storage    | minio                   | S3 compatible storage    |
| Saas Storage    | azurite                 | Azure compatible storage |

## Deploy

### Quick Start

- Install Tooling
  - Install `docker desktop`/`rancher-desktop`
  - Install `Lens` (K8S GUI)
  - Install `terraform`
  - Install [prerequisites](./docs/preparation/cli.md)
- Host preperation
  - edit hosts: add domain names
  - check docker network subnet range (adjust in main.tf -> variable)
  - generate mkcert as admin
  - run generate certificates.ps1
- Creation local cluster
  - cluster k3d: terraform init + apply
- Deploy
  - edit `terraform.tfvars`
  - deploy services: terraform init + apply
