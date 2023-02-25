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
| time | n/a |

### Modules

No modules.

### Resources

| Name | Type |
|------|------|
| [helm_release.cert-manager](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubectl_manifest.cluster-issuer](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubernetes_secret.ca-key-pair](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [time_sleep.wait_x_seconds](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| helm\_release | Helm Release | `any` | n/a | yes |
| namespace | Namespace | `string` | `"cert-manager"` | no |

### Outputs

No outputs.
<!-- END_TF_DOCS -->