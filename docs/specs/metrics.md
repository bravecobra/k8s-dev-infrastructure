<!-- BEGIN_TF_DOCS -->
### Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |

### Providers

| Name | Version |
|------|---------|
| helm | n/a |

### Modules

No modules.

### Resources

| Name | Type |
|------|------|
| [helm_release.metrics](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cluster-type | n/a | `string` | n/a | yes |
| helm\_release | Helm Release | `any` | n/a | yes |

### Outputs

No outputs.
<!-- END_TF_DOCS -->