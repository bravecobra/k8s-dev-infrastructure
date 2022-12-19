terraform {
  required_version = ">= 1.0"
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.14.0"
    }
    time = {
      source  = "hashicorp/time"
      version = ">= 0.9.1"
    }
    github = {
      source  = "integrations/github"
      version = ">= 5.9.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.4"
    }
    flux = {
      source  = "fluxcd/flux"
      version = ">= 0.20.0"
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