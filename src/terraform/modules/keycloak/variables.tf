variable "helm_release" {
  type    = string
  default = "17.0.2"
}

variable "domain-name" {
  description = "Domain Name"
}

variable "init_keycloak_user"{
    type = string
    default = "admin"
}

variable "namespace" {
  description = "Namespace"
  default     = "keycloak"
}

variable "forward_client_id" {
  type = string
  default = "traefik-forward-auth"
}

variable "include_domainrealm" {
  type = bool
  default = false
}