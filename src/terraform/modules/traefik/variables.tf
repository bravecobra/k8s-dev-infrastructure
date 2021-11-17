variable "ingress-ip" {
  type    = string
  default = "172.18.0.2"
}

variable "helm_release" {
  type    = string
  default = "10.3.6"
}

variable "domain-name" {
  description = "Domain Name"
}

variable "install_dashboards" {
  type = bool
}

variable "namespace" {
  description = "Namespace"
  default     = "traefik"
}