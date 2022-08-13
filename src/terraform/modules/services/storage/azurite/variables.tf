variable "domain-name" {
  description = "Domain Name"
}

variable "namespace" {
    description = "Namespace"
    default = "azurite"
}

variable "azurite_version" {
    description = "Version"
    default = "latest"
}