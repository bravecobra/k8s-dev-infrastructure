variable "helm_release" {
  type    = string
  default = "0.16.1"
}

variable "domain-name" {
  description = "Domain Name"
}

variable "namespace" {
  description = "Namespace"
}

variable "debug" {
  type    = bool
  default = false
}