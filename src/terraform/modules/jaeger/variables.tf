variable "helm_release" {
  type    = string
  default = "2.25.0"
}

variable "domain-name" {
  description = "Domain Name"
}

variable "install_dashboards" {
  type = bool
}

variable "namespace" {
  description = "Namespace"
  default     = "jaeger"
}