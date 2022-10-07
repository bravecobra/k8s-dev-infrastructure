variable "helm_release_loki" {
  description = "Helm Release Loki"
  default     = "2.6.0"
}

variable "helm_release_promtail" {
  description = "Helm Release Promtail"
  default     = "3.8.1"
}

variable "install_dashboards" {
  type = bool
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

variable "expose_ingestion" {
  type = bool
}
