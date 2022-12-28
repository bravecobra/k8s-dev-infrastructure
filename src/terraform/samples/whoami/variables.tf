variable "helm_release" {
  type    = string
}

variable "namespace" {
  description = "Namespace"
  default     = "whoami"
}

variable "domain-name" {
  description = "Domain Name"
}