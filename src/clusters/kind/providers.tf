terraform {
  required_version = ">= 1.0"
  required_providers {
    kind = {
      source  = "tehcyx/kind"
      version = ">= 0.0.13"
    }
    docker = {
      source                = "kreuzwerker/docker"
      version               = "~> 3.0.1"
      configuration_aliases = [docker.docker-windows]
    }
    environment = {
      source  = "EppO/environment"
      version = "~> 1.3.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.14.0"
    }
  }
}

provider "kind" {}

provider "docker" {
  host = local.is_windows != true ? null : "npipe:////.//pipe//docker_engine"
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "kind-${var.cluster-name}"
}

provider "environment" {}