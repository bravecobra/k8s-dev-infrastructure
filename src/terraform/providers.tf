terraform {
  required_version = ">= 1.0"
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.13.0"
    }
    time = {
      source  = "hashicorp/time"
      version = ">= 0.7.2"
    }
    github = {
      source  = "integrations/github"
      version = ">= 4.5.2"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "3.1.0"
    }
    flux = {
      source  = "fluxcd/flux"
      version = ">= 0.0.16"
    }
  }
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = var.cluster-context-name
}

provider "helm" {
  kubernetes {
    config_path    = "~/.kube/config"
    config_context = var.cluster-context-name
  }
}

provider "github" {
  owner = local.envs["GITHUB_OWNER"]
  token = local.envs["GITHUB_TOKEN"]
}