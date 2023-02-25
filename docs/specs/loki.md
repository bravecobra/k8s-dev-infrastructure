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
| [helm_release.loki](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.promtail](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubectl_manifest.loki_dashboard](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.loki_ingestion](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.promtail_dashboard](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| expose\_ingestion | n/a | `bool` | n/a | yes |
| helm\_release\_loki | Helm Release Loki | `any` | n/a | yes |
| helm\_release\_promtail | Helm Release Promtail | `any` | n/a | yes |
| install\_promtail | n/a | `bool` | n/a | yes |
| metrics\_enabled | n/a | `bool` | n/a | yes |
| namespace | Namespace | `any` | n/a | yes |
| tracing\_enabled | n/a | `bool` | n/a | yes |

### Outputs

No outputs.
<!-- END_TF_DOCS -->