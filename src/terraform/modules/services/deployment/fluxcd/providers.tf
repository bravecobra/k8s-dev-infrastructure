terraform {
  required_version = ">= 1.0"
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.13.0"
    }
  }
}

# terraform {
#   required_version = ">= 0.13"

#   required_providers {
#     # github = {
#     #   source  = "integrations/github"
#     #   version = ">= 4.5.2"
#     # }
#     # kubernetes = {
#     #   source  = "hashicorp/kubernetes"
#     #   version = ">= 2.0.2"
#     # }
#     # kubectl = {
#     #   source  = "gavinbunney/kubectl"
#     #   version = ">= 1.10.0"
#     # }
#     # flux = {
#     #   source  = "fluxcd/flux"
#     #   version = ">= 0.0.13"
#     # }
#     # tls = {
#     #   source  = "hashicorp/tls"
#     #   version = "3.1.0"
#     # }

#   }
# }

# # provider "flux" {}

# # provider "kubectl" {}

# # provider "kubernetes" {
# #   config_path = "~/.kube/config"
# # }

# # provider "github" {
# #   owner = var.github_owner
# #   token = var.github_token
# # }