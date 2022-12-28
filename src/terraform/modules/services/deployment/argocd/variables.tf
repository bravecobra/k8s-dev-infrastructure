variable "helm_release" {
  description = "Helm Release"
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