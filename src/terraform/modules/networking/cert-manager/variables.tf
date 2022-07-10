variable "helm_release" {
  description = "Helm Release"
  default     = "v1.5.4"
}

variable "namespace" {
  description = "Namespace"
  default     = "cert-manager"
}