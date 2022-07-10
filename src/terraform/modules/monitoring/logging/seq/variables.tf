variable "helm_release" {
  type    = string
}

variable "fluent_helm_release" {
  type = string
}

variable "domain-name" {
  description = "Domain Name"
}

variable "namespace" {
    description = "Namespace"
    default = "seq"
}

variable "expose_ingestion" {
  type = bool
}