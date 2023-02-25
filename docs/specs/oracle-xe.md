<!-- BEGIN_TF_DOCS -->
### Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| kubectl | >= 1.14.0 |

### Providers

| Name | Version |
|------|---------|
| kubectl | >= 1.14.0 |
| kubernetes | n/a |
| random | n/a |
| time | n/a |

### Modules

No modules.

### Resources

| Name | Type |
|------|------|
| [kubectl_manifest.oracle-cert](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.oracle-ingress](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.oracle-oem-ingress](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.oracle_manifests](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.oracledb](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubernetes_secret.admin-secret](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [kubernetes_secret.oracle_repository_secret](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [random_password.init_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [time_sleep.wait_x_seconds](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| domain-name | Domain Name | `string` | n/a | yes |
| expose\_oracle | n/a | `bool` | `false` | no |
| manifestfiles | n/a | `map(any)` | n/a | yes |
| namespace | Namespace | `string` | n/a | yes |
| oracle\_operator\_version | n/a | `string` | n/a | yes |
| oracle\_xe\_version | n/a | `string` | n/a | yes |
| storageclass | n/a | `string` | n/a | yes |

### Outputs

| Name | Description |
|------|-------------|
| oracle-password | n/a |
<!-- END_TF_DOCS -->