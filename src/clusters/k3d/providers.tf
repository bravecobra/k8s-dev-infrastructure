terraform {
  required_version = ">= 1.0"
  required_providers {
    docker = {
      source                = "kreuzwerker/docker"
      version               = "~> 2.23.0"
      configuration_aliases = [docker.docker-windows]
    }
  }
}

provider "docker" {
  host = local.is_windows != true ? null : "npipe:////.//pipe//docker_engine"
}

provider "random" {}