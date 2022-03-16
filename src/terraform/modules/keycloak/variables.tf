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
    default = "keycloak"
}

variable "init_keycloak_password"{
    type = string
    default = "Pa55w0rd"
}

variable "namespace" {
  description = "Namespace"
  default     = "keycloak"
}
