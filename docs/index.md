# K8S Dev Infrastructure

## Description

This repository contains a `kubernetes` dev infrastructure, providing both crosscutting concerns as well as Saas infrastructure. All this is provided through `terraform` deploying `helm` charts and custom configuration.

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
| Monitoring      | metrics-server          | Metrics                  |
| Monitoring      | opentelemetry-collector | Ingestion                |
| Saas Caching    | redis                   | Caching                  |
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
