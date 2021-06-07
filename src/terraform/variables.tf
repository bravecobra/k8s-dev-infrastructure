variable "cluster-context-name" {
    type = string
}

variable "domain-name" {
    type = string
}

variable "namespace" {
    type = string
}

variable "consul-datacenter" {
    type = string
}

variable "service-ip" {
    type = string
}

variable "install_consul" {
    type = bool
    default = true
}

variable "install_cert_manager" {
    type = bool
    default = false
}

variable "patch_coredns" {
    type = bool
    default = true
}

variable "install_traefik" {
    type = bool
    default = true
}

variable "install_elasticsearch" {
    type = bool
    default = true
}

variable "install_prometheus" {
    type = bool
    default = true
}

variable "install_jaeger" {
    type = bool
    default = true
}

variable "install_loki" {
    type = bool
    default = true
}

variable "install_identityserver4admin" {
    type = bool
    default = true
}