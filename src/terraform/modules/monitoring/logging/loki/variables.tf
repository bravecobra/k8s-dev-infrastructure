variable "helm_release_loki" {
  description = "Helm Release Loki"
}

variable "helm_release_promtail" {
  description = "Helm Release Promtail"
}

variable "install_promtail" {
  type = bool
}

variable "namespace" {
  description = "Namespace"
}

variable "tracing_enabled" {
  type = bool
}

variable "metrics_enabled" {
  type = bool
}

variable "expose_ingestion" {
  type = bool
}
