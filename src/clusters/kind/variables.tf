variable "cluster-name" {
  type = string
}

variable "worker-node-count" {
  type = number
  default = 0
}

variable "install_private_registry" {
  type = bool
  default = true
}