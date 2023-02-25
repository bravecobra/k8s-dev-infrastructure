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

### Modules

No modules.

### Resources

| Name | Type |
|------|------|
| [kubectl_manifest.azurite_deployment](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.azurite_ingress_blobs](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.azurite_ingress_queues](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.azurite_ingress_tables](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.azurite_service](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| azurite\_version | Version | `string` | `"latest"` | no |
| domain-name | Domain Name | `any` | n/a | yes |
| namespace | Namespace | `any` | n/a | yes |

### Outputs

No outputs.
<!-- END_TF_DOCS -->