terraform {
  required_version = ">= 0.13"
  required_providers {
    kubernetes-alpha = {
      source = "hashicorp/kubernetes-alpha"
      version = "0.4.1"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }
}

provider "kubectl" {
  config_path    = "~/.kube/config"
  config_context = "${var.cluster-context-name}"
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "${var.cluster-context-name}"
}

provider "kubernetes-alpha" {
  config_path    = "~/.kube/config"
  config_context = "${var.cluster-context-name}"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
    config_context = "${var.cluster-context-name}"
  }
}