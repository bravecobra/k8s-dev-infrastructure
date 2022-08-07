variable "helm_release" {
  type    = string
  default = "2.5.5"
}

variable "namespace" {
  description = "Namespace"
  default     = "whoami"
}

variable "domain-name" {
  description = "Domain Name"
}