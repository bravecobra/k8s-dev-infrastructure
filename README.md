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
| Monitoring      | vpa                     | Autoscaling              |
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

- Install the tooling
  - Install a `Docker` environment : [Docker desktop](https://www.docker.com/products/docker-desktop/) or [Rancher desktop](https://rancherdesktop.io/)
  - Install the tooling [prerequisites](https://bravecobra.github.io/k8s-dev-infrastructure/preparation/). A couple of binaries are required to run this.
  - Install [Lens](https://k8slens.dev/), a K8S GUI (optional)
- Prepare your local setup (create certificates, DNS, a running cluster, etc..). Just follow the [docs](https://bravecobra.github.io/k8s-dev-infrastructure/installation-terraform/).
- Final step: Deploy!
  - edit `terraform.tfvars`. You can uncomment the install booleans to choose what to install on your cluster.
  - deploy services:

    ```shell
    cd ./src/terraform
    terraform init
    terraform apply --auto-approve
    ```

### Documentation

The full docs are available at [Github Pages](https://bravecobra.github.io/k8s-dev-infrastructure/)

#### Build the docs locally

```shell
pip install --user -f requirements.txt
mkdocs build
mkdocs serve
```
