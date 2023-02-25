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
| kubernetes | n/a |
| random | n/a |

### Modules

No modules.

### Resources

| Name | Type |
|------|------|
| [helm_release.prometheus](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubectl_manifest.jaeger_monitor](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.prometheus-cert](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.rabbitmq-monitor](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.traefik-monitor](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.traefik-rules](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [random_password.init_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [kubernetes_secret.grafana-secret](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/secret) | data source |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| domain-name | Domain Name | `any` | n/a | yes |
| helm\_release | n/a | `string` | n/a | yes |
| install\_grafana | n/a | `bool` | `false` | no |
| install\_prometheus | n/a | `bool` | `false` | no |
| metrics\_argocd | n/a | `bool` | `true` | no |
| metrics\_jaeger | n/a | `bool` | `true` | no |
| metrics\_linkerd | n/a | `bool` | `false` | no |
| metrics\_loki | n/a | `bool` | `true` | no |
| metrics\_minio | n/a | `bool` | `false` | no |
| metrics\_rabbitmq | n/a | `bool` | `false` | no |
| metrics\_tempo | n/a | `bool` | `true` | no |
| namespace | Namespace | `any` | n/a | yes |

### Outputs

| Name | Description |
|------|-------------|
| admin-password | n/a |
| admin-user | n/a |
<!-- END_TF_DOCS -->