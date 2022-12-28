variable "helm_release" {
  type    = string
}

variable "domain-name" {
  description = "Domain Name"
}

variable "install_dashboards" {
  type = bool
}

variable "namespace" {
  description = "Namespace"
}