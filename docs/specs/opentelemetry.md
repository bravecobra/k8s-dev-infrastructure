<!-- BEGIN_TF_DOCS -->
### Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| kubectl | >= 1.14.0 |

### Providers

| Name | Version |
|------|---------|
| helm | n/a |
| kubectl | >= 1.14.0 |

### Modules

No modules.

### Resources

| Name | Type |
|------|------|
| [helm_release.opentelemetry](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubectl_manifest.collector](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.otel-ingestion-grpc](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.otel-ingestion-http](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.otel_clusterrole](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.otel_clusterrole_binding](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| expose\_ingestion | Expose Ingestion | `bool` | `false` | no |
| helm\_release | Helm Release | `any` | n/a | yes |
| install\_jaeger | Install jaeger | `bool` | `false` | no |
| install\_loki | Install Loki | `bool` | `false` | no |
| k8smonitoring\_enabled | Flag to enable cluster monitoring | `bool` | `false` | no |
| monitoring\_backend | the backend to ship telemetry to | `string` | `"grafana"` | no |
| namespace | Namespace | `any` | n/a | yes |

### Outputs

No outputs.
<!-- END_TF_DOCS -->