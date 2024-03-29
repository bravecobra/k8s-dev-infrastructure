variable "helm_release" {
  type = string
}

variable "metrics_jaeger" {
  type    = bool
  default = true
}

variable "metrics_argocd" {
  type    = bool
  default = true
}

variable "metrics_loki" {
  type    = bool
  default = true
}

variable "metrics_tempo" {
  type    = bool
  default = true
}

variable "metrics_minio" {
  type    = bool
  default = false
}

variable "metrics_linkerd" {
  type    = bool
  default = false
}

variable "metrics_rabbitmq" {
  type    = bool
  default = false
}

variable "metrics_cadvisor" {
  type    = bool
  default = false
}

variable "domain-name" {
  description = "Domain Name"
}

variable "namespace" {
  description = "Namespace"
}

variable "install_prometheus" {
  type    = bool
  default = false
}
variable "install_grafana" {
  type    = bool
  default = false
}