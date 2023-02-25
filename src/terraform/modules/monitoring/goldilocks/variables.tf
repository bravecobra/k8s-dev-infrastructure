variable "helm_release" {
  type        = string
  description = "Version of the helm chart to install"
}

variable "domain-name" {
  description = "Domain Name"
}

variable "namespace" {
  description = "Namespace"
}
