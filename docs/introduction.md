# Introduction

Using proven opensource software projects, this repo builds a coherent dev environment that offers similar services that the big cloud providers also offer:

| Capability      | Type | This repo                   | AWS                    | Azure                  | Google |
| --------------- | ---- | --------------------------- | ---------------------- | ---------------------- | ------ |
| Logging         | Core | loki/promtail or seq/fluent | CloudWatch             | AppInsights            |        |
| Tracing         | Core | jaeger                      | X-Ray                  | AppInsights            |        |
| Metrics         | Core | prometheus + metrics-server | CloudWatch             | AppInsights            |        |
| Dashboards      | Core | grafana                     | CloudWatch             | AppInsights            |        |
| Service Mesh    | Core | linkerd                     | AppMesh                | Open Service Mesh      |        |
| Ingress         | Core | traefik                     | CloudFront/API Gateway | Azure FrontDoor        |        |
| Certificates    | Core | cert-manager                | Certificate Manager    | Management Certificate |        |
| Secrets         | Saas | vault                       | SSM                    | Azure Vault            |        |
| Storage         | Saas | minio / azurite             | S3                     | Azure Storage          |        |
| Config          | Saas | etcd                        | Parameter Store        | App Config             |        |
| Appl Deployment | Saas | argocd                      | /                      | /                      |        |
| Search          | Saas | elasticsearch               | Opensearch Service     | Elastic                |        |
| Auth            | Saas | keycloak/identityserver4    | IAM                    | IAM                    |        |
