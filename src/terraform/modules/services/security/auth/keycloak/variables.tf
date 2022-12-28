variable "helm_release" {
  type = string
}

variable "domain-name" {
  description = "Domain Name"
}

variable "init_keycloak_user" {
  type    = string
  default = "admin"
}

variable "namespace" {
  description = "Namespace"
}

variable "forward_client_id" {
  type    = string
  default = "traefik-forward-auth"
}

variable "include_domainrealm" {
  type    = bool
  default = false
}