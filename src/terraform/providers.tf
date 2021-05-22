terraform {
  required_providers {
    kubernetes-alpha = {
      source = "hashicorp/kubernetes-alpha"
      version = "0.3.2"
    }
  }
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