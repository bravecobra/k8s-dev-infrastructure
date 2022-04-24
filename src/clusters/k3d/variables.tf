variable "cluster-name" {
  type = string
}

variable "server-node-count" {
  type = number
  default = 1
}

variable "worker-node-count" {
  type = number
  default = 0
}

variable "install_private_registry" {
  type = bool
  default = true
}

variable "k3s-version" {
  description = "The K3s version to use"
  type        = string
  default     = "latest"
}

variable "k3d-cluster-name" {
  default = ["k3d"]
  type    = list(string)
}

variable "k3d-cluster-domain" {
  type    = string
}

variable "k3d-cluster-port" {
  default = 6445
  type    = number
}

variable "k3d-cluster-ip" {
  default = "0.0.0.0"
  type    = string
}

variable "expose_azurite" {
  type = bool
  default = false
}