<!-- BEGIN_TF_DOCS -->
### Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| flux | >= 0.0.16 |
| github | >= 4.28.0 |
| kubectl | >= 1.14.0 |
| tls | 4.0.4 |

### Providers

| Name | Version |
|------|---------|
| flux | >= 0.0.16 |
| github | >= 4.28.0 |
| kubectl | >= 1.14.0 |
| kubernetes | n/a |
| null | n/a |
| tls | 4.0.4 |

### Modules

No modules.

### Resources

| Name | Type |
|------|------|
| [github_branch_default.main](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch_default) | resource |
| [github_repository.main](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository) | resource |
| [github_repository_deploy_key.main](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_deploy_key) | resource |
| [github_repository_file.flux_cert](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [github_repository_file.install](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [github_repository_file.kustomize](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [github_repository_file.sync](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [github_repository_file.weave-gitops](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [github_repository_file.weave-gitops-repo](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [github_repository_file.weave-ingress](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [kubectl_manifest.sync_kustomize](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.sync_repo](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubernetes_secret.main](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [null_resource.flux_install](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [tls_private_key.main](https://registry.terraform.io/providers/hashicorp/tls/4.0.4/docs/resources/private_key) | resource |
| [flux_install.main](https://registry.terraform.io/providers/fluxcd/flux/latest/docs/data-sources/install) | data source |
| [flux_sync.main](https://registry.terraform.io/providers/fluxcd/flux/latest/docs/data-sources/sync) | data source |
| [github_repository.main](https://registry.terraform.io/providers/integrations/github/latest/docs/data-sources/repository) | data source |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| branch | branch name | `string` | `"master"` | no |
| domain-name | n/a | `string` | n/a | yes |
| namespace | Namespace | `any` | n/a | yes |
| repository\_create | n/a | `bool` | `false` | no |
| repository\_name | github repository name | `string` | n/a | yes |
| repository\_visibility | How visible is the github repo | `string` | `"private"` | no |
| target\_path | flux sync target path | `string` | n/a | yes |

### Outputs

No outputs.
<!-- END_TF_DOCS -->