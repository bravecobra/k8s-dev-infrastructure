variable "helm_release" {
  type = string
}

variable "domain-name" {
  description = "Domain Name"
}

variable "namespace" {
  description = "Namespace"
}

variable "expose_postgres" {
  type    = bool
  default = false
}