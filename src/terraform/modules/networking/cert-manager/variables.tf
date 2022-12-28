variable "helm_release" {
  description = "Helm Release"
}

variable "namespace" {
  description = "Namespace"
  default     = "cert-manager"
}