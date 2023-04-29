terraform {
  required_version = ">= 1.0"
  required_providers {
    docker = {
      source                = "kreuzwerker/docker"
      version               = "~> 3.0.2"
      configuration_aliases = [docker.docker-windows]
    }
  }
}

provider "docker" {
  host = local.envs["DOCKER_HOST"] != "" ? local.envs["DOCKER_HOST"] : local.is_windows != true ? null : "npipe:////./pipe/docker_engine"
}

provider "random" {}