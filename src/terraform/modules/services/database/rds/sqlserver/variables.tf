variable "helm_release" {
  type    = string
}

variable "domain-name" {
  description = "Domain Name"
}

variable "namespace" {
  description = "Namespace"
}

variable "expose_mssql" {
  type = bool
  default = false
}