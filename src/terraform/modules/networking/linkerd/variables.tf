variable "helm_release" {
  type = string
}

variable "helm_release_crds" {
  type = string
}

variable "helm_release_viz" {
  type = string
}

variable "helm_release_jaeger" {
  type = string
}

variable "prometheus" {
  type    = bool
  default = false
}

variable "tracing_dataplane" {
  type    = bool
  default = false
}

variable "tracing_controlplane" {
  type    = bool
  default = false
}

variable "tracing_enabled" {
  type    = bool
  default = false
}

variable "metrics_external" {
  type    = bool
  default = true
}

variable "domain-name" {
  description = "Domain Name"
}

variable "namespace" {
  description = "Namespace"
  default     = "linkerd"
}

