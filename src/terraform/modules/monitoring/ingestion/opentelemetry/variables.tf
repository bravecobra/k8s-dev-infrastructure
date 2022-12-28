variable "helm_release" {
  description = "Helm Release"
}

variable "namespace" {
  description = "Namespace"
}

variable "expose_ingestion" {
  description = "Expose Ingestion"
  type        = bool
  default     = false
}


variable "install_jaeger" {
  description = "Install jaeger"
  type        = bool
  default     = false
}

variable "install_loki" {
  description = "Install Loki"
  type        = bool
  default     = false
}

variable "monitoring_backend" {
  description = "the backend to ship telemetry to"
  type        = string
  default     = "grafana"

  # using contains()
  validation {
    condition     = contains(["grafana", "newrelic", "datadog"], var.monitoring_backend)
    error_message = "Invalid input, options: \"grafana\", \"newrelic\",  \"datadog\"."
  }
}

variable "k8smonitoring_enabled" {
  type    = bool
  default = false
}