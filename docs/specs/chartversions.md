<!-- BEGIN_TF_DOCS -->
### Requirements

No requirements.

### Providers

No providers.

### Modules

No modules.

### Resources

No resources.

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| config\_file\_content | n/a | `string` | n/a | yes |
| input\_versions | Data object representing fields for HelmChart version | <pre>map(object({<br>    chart_version = string<br>  }))</pre> | n/a | yes |

### Outputs

| Name | Description |
|------|-------------|
| chart\_versions | n/a |
<!-- END_TF_DOCS -->