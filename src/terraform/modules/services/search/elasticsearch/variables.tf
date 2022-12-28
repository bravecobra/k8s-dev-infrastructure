variable "helm_release" {
  type    = string
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
}