variable "helm_release" {
  type    = string
  default = "2.25.0"
}

variable "domain-name" {
  description = "Domain Name"
}

variable "namespace" {
  description = "Namespace"
  default     = "etcd"
}