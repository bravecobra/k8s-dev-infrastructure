variable "helm_release" {
  description = "Helm Release Tempo"
  default     = "0.15.4"
}

variable "namespace" {
  description = "Namespace"
  default     = "tempo"
}