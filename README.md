# K8S Dev Infrastructure

## Description

This repository contains a [kubernetes](https://kubernetes.io/) dev infrastructure, providing both crosscutting concerns as well as Saas services. This is provided through [terraform](https://www.terraform.io/) scripts deploying (mostly) [helm](https://helm.sh/) charts and custom configuration.

![Terraform syntax](https://github.com/bravecobra/k8s-dev-infrastructure/actions/workflows/build.yml/badge.svg)
![E2E workflow](https://github.com/bravecobra/k8s-dev-infrastructure/actions/workflows/e2e.yml/badge.svg)

## Components

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
| Monitoring      | grafana                 | Dashboards               |
| Monitoring      | metrics-server          | Metrics                  |
| Monitoring      | opentelemetry-collector | Telemetry Ingestion      |
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
| Saas Storage    | docker-registry         | Docker Registry          |

## Deploy

### Quick Start

- Install Tooling
  - Install a `Docker` environment : [Docker desktop](https://www.docker.com/products/docker-desktop/) or [Rancher desktop](https://rancherdesktop.io/)
  - Install tooling [prerequisites](./docs/preparation.md)
  - Install [Lens](https://k8slens.dev/), a K8S GUI (optional)
- Create a local `k8s` cluster to deploy on
  - Edit your `hosts` file: add domain names to resolve to `localhost` so we can point them to the local cluster
  - Check the docker network subnet range (adjust in `main.tf `-> variable) so there is no overlap with an existing one.
  - Generate `mkcert` as admin
  - Run generate a certificate:

    ```shell
    ./src/terraform/certificates.ps1
    ```

  - Creation local cluster
    - cluster k3d:

    ```shell
    cd ./src/clusters/k3d
    terraform init
    terraform apply --auto-approve
    ```

    - cluster kind:

    ```shell
    cd ./src/clusters/kind
    terraform init
    terraform apply --auto-approve
    ```

- Deploy
  - edit `terraform.tfvars`
  - deploy services:

    ```shell
    cd ./src/terraform
    terraform init
    terraform apply --auto-approve
    ```

### Documentation

The docs are available at [Github Pages](https://bravecobra.github.io/k8s-dev-infrastructure/)

#### Build the docs locally

```shell
pip install --user -f requirements.txt
mkdocs build
mkdocs serve
```
