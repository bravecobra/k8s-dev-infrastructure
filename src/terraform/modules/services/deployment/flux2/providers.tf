terraform {
  required_version = ">= 1.0"

  required_providers {
    github = {
      source  = "integrations/github"
      version = ">= 4.28.0"
    }
    # kubernetes = {
    #   source  = "hashicorp/kubernetes"
    #   version = ">= 2.0.2"
    # }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.14.0"
    }
    flux = {
      source  = "fluxcd/flux"
      version = ">= 0.0.16"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "3.4.0"
    }
  }
}
