variable "helm_release" {
  type    = string
}

variable "mssql_helm_release" {
  type    = string
}

variable "domain-name" {
  type = string
}

variable "namespace" {
  description = "Namespace"
}

variable "storageclass" {
  type = string
}