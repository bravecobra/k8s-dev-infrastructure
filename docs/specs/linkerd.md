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
| local | n/a |
| null | n/a |
| time | n/a |

### Modules

No modules.

### Resources

| Name | Type |
|------|------|
| [helm_release.linkerd](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.linkerd-jaeger](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.linkerd-viz](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.linkerd_crds](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubectl_manifest.linkerd-cert](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.linkerd-identity-cert](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.linkerd-trust-anchor-cert](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.linkerd-trust-anchor-issuer](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.linkerd-viz-ingress](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.linkerd-viz-ingress-secret](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [null_resource.fetch_ca](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [time_sleep.wait_x_seconds](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [local_file.ca-cert](https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/file) | data source |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| domain-name | Domain Name | `any` | n/a | yes |
| helm\_release | n/a | `string` | n/a | yes |
| helm\_release\_crds | n/a | `string` | n/a | yes |
| helm\_release\_jaeger | n/a | `string` | n/a | yes |
| helm\_release\_viz | n/a | `string` | n/a | yes |
| metrics\_external | n/a | `bool` | `true` | no |
| namespace | Namespace | `string` | `"linkerd"` | no |
| prometheus | n/a | `bool` | `false` | no |
| tracing\_controlplane | n/a | `bool` | `false` | no |
| tracing\_dataplane | n/a | `bool` | `false` | no |
| tracing\_enabled | n/a | `bool` | `false` | no |

### Outputs

| Name | Description |
|------|-------------|
| ca-cert | CA certificate |
<!-- END_TF_DOCS -->