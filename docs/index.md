# K8S Dev Infrastructure

## Description

This repository contains a kubernetes dev infrastructure, providing both crosscutting concerns as well as Saas infrastructure. All this is provided through terraform deploying helm charts and custom configuration.

### Cross-cutting concerns

- Certificates (cert-manager)
- Reverse proxy (traefik)
- Logging (seq or loki)
- Metrics (prometheus)
- Tracing (jaeger)
- Service discovery (linkerd)

### Saas

- Elastic stack (elasticsearch, kibana)
- Secret management (vault)
- Identity Provider (IdentityServer4 or Keycloak)
- Configuration management/KV (etcd)
- ArgoCD (CI/CD)
- Storage (Minio)
