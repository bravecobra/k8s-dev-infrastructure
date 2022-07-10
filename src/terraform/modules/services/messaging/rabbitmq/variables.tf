variable "helm_release" {
  type    = string
}

variable "domain-name" {
  description = "Domain Name"
}

variable "namespace" {
  description = "Namespace"
  default     = "rabbitmq"
}

variable "install_dashboards" {
  type = bool
  description = "Installs grafana dashboard"
  default     = false
}