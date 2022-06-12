variable "helm_release" {
  description = "Helm Release"
#   default     = "0.7.0"
}

variable "namespace" {
    description = "Namespace"
    default = "opentelemetry"
}

variable "expose_ingestion" {
   description = "Namespace"
   type = bool
   default = false
}
