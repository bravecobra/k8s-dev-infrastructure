# variable "helm_release" {
#   type = string
# }

variable "domain-name" {
  description = "Domain Name"
  type        = string
}

variable "namespace" {
  description = "Namespace"
  type        = string
}

variable "expose_oracle" {
  type    = bool
  default = false
}

variable "oracle_operator_version" {
  type = string
}

variable "oracle_xe_version" {
  type = string
}

variable "manifestfiles" {
  type = map(any)
}