variable "helm_release" {
  type    = string
  default = "2.11.0"
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

