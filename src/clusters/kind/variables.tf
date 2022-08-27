variable "cluster-name" {
  type = string
}

variable "worker-node-count" {
  type = number
  default = 0
}

variable "kind_version" {
  default = "v1.24.3"
  type = string
}

variable "install_private_registry" {
  type = bool
  default = true
}

variable "kind-network-subnet" {
  default = "172.19.0.0/16"
  type    = string
}

variable "kind-network-gateway" {
  default = "172.19.0.1"
  type    = string
}

# variable "expose_azurite" {
#   type    = bool
#   default = false
# }
# variable "expose_seq" {
#   type    = bool
#   default = false
# }
# variable "expose_opentelemetry" {
#   type    = bool
#   default = false
# }

# variable "expose_jaeger" {
#   type    = bool
#   default = false
# }
# # variable "expose_prometheus" {
# #   type    = bool
# #   default = false
# # }
# # variable "expose_elasticsearch" {
# #   type    = bool
# #   default = false
# # }
# variable "expose_rabbitmq" {
#   type    = bool
#   default = false
# }

# variable "expose_loki" {
#   type    = bool
#   default = false
# }