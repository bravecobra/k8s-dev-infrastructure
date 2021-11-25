# Introduction

Using proven opensource software projects, this repo builds a coherent dev environment that offers similar services that the big cloud providers also offer:

| Capability   | This repo     | AWS                    | Azure                  | Google |
| ------------ | ------------- | ---------------------- | ---------------------- | ------ |
| Logging      | loki/promtail | CloudWatch             | AppInsights            |        |
| Tracing      | jaeger        | X-Ray                  | AppInsights            |        |
| Metrics      | prometheus    | CloudWatch             | AppInsights            |        |
| Dashboards   | grafana       | CloudWatch             | AppInsights            |        |
| Service Mesh | linkerd       | AppMesh                | Open Service Mesh      |        |
| Ingress      | traefik       | CloudFront/API Gateway | Azure FrontDoor        |        |
| Secrets      | vault         | SSM                    | Azure Vault            |        |
| Certificates | cert-manager  | Certificate Manager    | Management Certificate |        |
| Storage      | minio         | S3                     | Azure Storage          |        |
