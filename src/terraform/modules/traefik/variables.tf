variable "loadbalancer-ip" {
  type    = string
  default = "172.19.0.2"
}

variable "node-ips" {
  type    = list
  default = [
    "172.19.0.2"
  ]
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

variable "use_metrics" {
  type = bool
  default = false
}

variable "expose_azurite" {
  type = bool
  default = false
}