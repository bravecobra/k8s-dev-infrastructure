variable "helm_release" {
  description = "Helm Release"
  default     = "3.24.0"
}

variable "domain-name" {
  description = "Domain Name"
}

variable "namespace" {
  description = "Namespace"
}

variable "install_prometheus" {
  type        = bool
  description = "Expose metrics"
}