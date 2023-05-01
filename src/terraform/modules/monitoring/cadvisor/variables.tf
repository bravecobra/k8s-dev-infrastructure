variable "helm_release" {
  type        = string
  description = "Version of the helm chart to install"
}

variable "namespace" {
  description = "Namespace"
  type = string
}

variable "metrics_enabled" {
  type = bool
  description = "whether to expose the metrics for prometheus"
}
