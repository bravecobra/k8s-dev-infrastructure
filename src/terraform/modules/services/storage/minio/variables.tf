variable "helm_release" {
  type    = string
}

variable "domain-name" {
  description = "Domain Name"
}

variable "namespace" {
    description = "Namespace"
    default = "minio"
}

variable "metrics" {
    description = "Enable metrics"
    default = "false"
}