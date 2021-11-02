variable "helm_release" {
  type    = string
  default = "2.11.0"
}

variable "prometheus" {
  type    = bool
  default = false
}

variable "tracing_dataplane" {
  type    = bool
  default = false
}

variable "tracing_controlplane" {
  type    = bool
  default = false
}

variable "domain-name" {
  description = "Domain Name"
}