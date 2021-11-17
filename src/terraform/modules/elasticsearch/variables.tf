variable "helm_release" {
  type    = string
  default = "1.8.0"
}

variable "install_kibana" {
  type    = bool
  default = true
}

variable "install_elasticsearch" {
  type    = bool
  default = true
}

variable "domain-name" {
  description = "Domain Name"
}

variable "namespace" {
  description = "Namespace"
  default     = "elasticsearch"
}