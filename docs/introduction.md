# Introduction

Using proven opensource software projects, this repo builds a coherent dev environment that offers similar services that the big cloud providers also offer:

| Provides     | Used          | AWS                 | Azure                  | Google |
| ------------ | ------------- | ------------------- | ---------------------- | ------ |
| Logging      | loki/promtail | CloudWatch          |                        |        |
| Tracing      | jaeger        | X-Ray               | AppInsights            |        |
| Metrics      | prometheus    | CloudWatch          |                        |        |
| Dashboards   | grafana       | CloudWatch          |                        |        |
| Service Mesh | consul        | AppMesh             |                        |        |
| Ingress      | traefik       | CloudFront          |                        |        |
| Secrets      | vault         | SSM                 | Azure Vault            |        |
| Certificates | cert-manager  | Certificate Manager | management certificate |        |
