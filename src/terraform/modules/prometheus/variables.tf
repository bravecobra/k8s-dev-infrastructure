variable "helm_release" {
  type    = string
  default = "19.0.2"
}

variable "metrics_jaeger" {
  type    = bool
  default = true
}

variable "metrics_argocd" {
  type    = bool
  default = true
}

variable "metrics_loki" {
  type    = bool
  default = true
}

variable "domain-name" {
  description = "Domain Name"
}

variable "namespace" {
  description = "Namespace"
  default     = "prometheus"
}