resource "kind_cluster" "devinfra-cluster" {
  name           = var.cluster-name
  wait_for_ready = true

  kind_config {
    kind        = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"
    containerd_config_patches = [
      <<-TOML
            [plugins."io.containerd.grpc.v1.cri".registry.mirrors."localhost:5000"]
                endpoint = ["http://kind-registry:5000"]
            TOML
    ]
    networking {
      ip_family          = "ipv4"
      api_server_address = "127.0.0.1"
    }
    node {
      role = "control-plane"
      kubeadm_config_patches = [
        "kind: InitConfiguration\nnodeRegistration:\n  kubeletExtraArgs:\n    node-labels: \"ingress-ready=true\"\n"
      ]
      extra_port_mappings {
        host_port      = 80
        container_port = 80
        protocol       = "tcp"
        listen_address = "127.0.0.1"
      }
      extra_port_mappings {
        host_port      = 443
        container_port = 443
        protocol       = "tcp"
        listen_address = "127.0.0.1"
      }
      extra_port_mappings {
        host_port      = 8100
        container_port = 8100
        protocol       = "tcp"
        listen_address = "127.0.0.1"
      }
    }
    // node {
    //   role = "worker"
    // }
    // node {
    //   role = "worker"
    // }
    // node {
    //   role = "worker"
    // }
  }
}

locals {
  is_windows = substr(pathexpand("~"), 0, 1) == "/" ? false : true
}

data "docker_registry_image" "registry" {
  name = "registry:2"
}

resource "docker_image" "registry" {
  count = var.install_private_registry ? 1 : 0
  name          = data.docker_registry_image.registry.name
  pull_triggers = [data.docker_registry_image.registry.sha256_digest]
}

resource "docker_container" "registry" {
  count = var.install_private_registry ? 1 : 0
  name  = "kind-registry"
  image = docker_image.registry[0].latest
  ports {
    external = 5000
    internal = 5000
  }
  networks_advanced {
    name = "kind"
  }
  depends_on = [
    kind_cluster.devinfra-cluster
  ]
}

resource "time_sleep" "wait_x_seconds" {
  count = length(data.environment_variables.wsl.items) != 0 ? 1 : 0
  depends_on = [
    kind_cluster.devinfra-cluster
  ]
  create_duration = "10s"
}

resource "kubectl_manifest" "config-registry" {
  count = var.install_private_registry ? 1 : 0
  depends_on = [
    docker_container.registry,
    time_sleep.wait_x_seconds
  ]
  yaml_body = file("${path.module}/config-registry.yaml")
}

data "environment_variables" "wsl" {
    filter = "WSL_DISTRO_NAME"
}

resource "null_resource" "backup-kind-config" {
  count = length(data.environment_variables.wsl.items) != 0 ? 1 : 0
  provisioner "local-exec" {
    command = "whoami | xargs -i cp /mnt/c/users/'{}'/.kube/config /mnt/c/users/'{}'/.kube/config.bak"
  }
  depends_on = [
    kind_cluster.devinfra-cluster
  ]
}

resource "null_resource" "copy-kind-config" {
    count = length(data.environment_variables.wsl.items) != 0 ? 1 : 0
  provisioner "local-exec" {
    command = "whoami | xargs -i cp ~/.kube/config /mnt/c/users/'{}'/.kube/config"
  }
  depends_on = [
    null_resource.backup-kind-config
  ]
}