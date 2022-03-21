variable "helm_release" {
  type    = string
  default = "17.0.2"
}

variable "domain-name" {
  description = "Domain Name"
}

// variable "install_dashboards" {
//   type = bool
// }

variable "init_keycloak_user"{
    type = string
    default = "admin"
}

variable "init_keycloak_password"{
    type = string
    default = "Pa55w0rd"
}

variable "namespace" {
  description = "Namespace"
  default     = "keycloak"
}

variable "forward_client_id" {
  type = string
  default = "traefik-forward-auth"
}

variable "forward_client_secret" {
  type = string
}