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
| [helm_release.traefik](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubectl_manifest.cert-store](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.dashboard](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.http-redirect-middleware](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.traefik-cert](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.traefik-metrics-service](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.traefik_dashboard](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cluster-type | n/a | `string` | n/a | yes |
| domain-name | Domain Name | `any` | n/a | yes |
| expose\_azurite | n/a | `bool` | `false` | no |
| expose\_jaeger | n/a | `bool` | `false` | no |
| expose\_kafka | n/a | `bool` | `false` | no |
| expose\_loki | n/a | `bool` | `false` | no |
| expose\_mariadb | n/a | `bool` | `false` | no |
| expose\_mongodb | n/a | `bool` | `false` | no |
| expose\_mssql | n/a | `bool` | `false` | no |
| expose\_mysql | n/a | `bool` | `false` | no |
| expose\_opentelemetry | n/a | `bool` | `false` | no |
| expose\_oracle | n/a | `bool` | `false` | no |
| expose\_postgres | n/a | `bool` | `false` | no |
| expose\_rabbitmq | n/a | `bool` | `false` | no |
| expose\_redis | n/a | `bool` | `false` | no |
| expose\_seq | n/a | `bool` | `false` | no |
| helm\_release | n/a | `string` | n/a | yes |
| install\_dashboards | n/a | `bool` | n/a | yes |
| loadbalancer-ip | n/a | `string` | `"172.19.0.2"` | no |
| namespace | Namespace | `string` | `"traefik"` | no |
| node-ips | n/a | `list(any)` | <pre>[<br>  "172.19.0.2"<br>]</pre> | no |
| use\_metrics | n/a | `bool` | `false` | no |
| use\_tracing | n/a | `bool` | `false` | no |

### Outputs

No outputs.
<!-- END_TF_DOCS -->