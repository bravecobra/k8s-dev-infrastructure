variable "config_file_content" {
  type = string
}

variable "input_versions" {
  type = map(object({
    chart_version = string
  }))
  description = "Data object representing fields for HelmChart version"
}