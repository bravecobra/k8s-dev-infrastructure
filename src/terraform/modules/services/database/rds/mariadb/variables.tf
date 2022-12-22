variable "helm_release" {
  type = string
}

variable "domain-name" {
  description = "Domain Name"
}

variable "namespace" {
  description = "Namespace"
}

variable "expose_mariadb" {
  type    = bool
  default = false
}

variable "storageclass" {
  type = string
}