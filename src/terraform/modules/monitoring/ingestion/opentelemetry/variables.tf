variable "helm_release" {
  description = "Helm Release"
#   default     = "0.7.0"
}

variable "namespace" {
  description = "Namespace"
}

variable "expose_ingestion" {
  description = "Expose Ingestion"
  type = bool
  default = false
}


variable "install_jaeger" {
  description = "Install jaeger"
  type = bool
  default = false
}

variable "install_loki" {
  description = "Install Loki"
  type = bool
  default = false
}