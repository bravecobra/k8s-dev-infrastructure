variable "cluster-name" {
  type        = string
  description = "The cluster name"
}

variable "worker-node-count" {
  type        = number
  default     = 0
  description = "The amount of worker nodes (doesn't affect anything now)"
}

variable "kind_version" {
  default     = "v1.24.3"
  type        = string
  description = "The KinD image version to use"
}

variable "install_private_registry" {
  type        = bool
  default     = true
  description = "Install a private docker registry"
}

variable "kind-network-subnet" {
  default     = "172.19.0.0/16"
  type        = string
  description = "The subnet to run the cluster in"
}

variable "kind-network-gateway" {
  default     = "172.19.0.1"
  type        = string
  description = "The default gateway for the cluster network"
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