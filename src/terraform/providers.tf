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