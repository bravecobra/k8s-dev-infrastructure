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
| random | n/a |

### Modules

No modules.

### Resources

| Name | Type |
|------|------|
| [helm_release.redis](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubectl_manifest.redis-cert](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.redis-ingress](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.redis_commander_deployment](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.redis_commander_ingress](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.redis_commander_service](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [random_password.init_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| domain-name | Domain Name | `any` | n/a | yes |
| expose\_redis | Expose Redis | `bool` | n/a | yes |
| helm\_release | n/a | `string` | n/a | yes |
| namespace | Namespace | `any` | n/a | yes |
| replica\_count | Replicas count | `number` | `0` | no |

### Outputs

| Name | Description |
|------|-------------|
| redis-password | n/a |
<!-- END_TF_DOCS -->