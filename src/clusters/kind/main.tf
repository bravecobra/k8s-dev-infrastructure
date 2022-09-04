resource "docker_network" "kind_network" {
  name = "kind"
  driver = "bridge"
  ipv6 = false
  ipam_config {
      subnet = "fc00:f853:ccd:e793::/64"
  }
  ipam_config {
      subnet = var.kind-network-subnet
      gateway = var.kind-network-gateway
  }
  options = {
    "com.docker.network.bridge.enable_ip_masquerade "= "true"
    "com.docker.network.driver.mtu" = "1500"
  }
}

resource "kind_cluster" "devinfra-cluster" {
  name           = var.cluster-name
  wait_for_ready = true
  node_image = "kindest/node:${var.kind_version}"
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
      # service_subnet     = var.kind-network-subnet
      # pod_subnet         = var.kind-network-subnet
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
      # Azurite (kind doesn't seem to allow to publish port above 10k)
      # extra_port_mappings {
      #   host_port      = 10000
      #   container_port = 10000
      #   protocol       = "tcp"
      #   listen_address = "127.0.0.1"
      # }
      # extra_port_mappings {
      #   host_port      = 10001
      #   container_port = 10001
      #   protocol       = "tcp"
      #   listen_address = "127.0.0.1"
      # }
      # extra_port_mappings {
      #   host_port      = 10002
      #   container_port = 10002
      #   protocol       = "tcp"
      #   listen_address = "127.0.0.1"
      # }
      # SEQ
      extra_port_mappings {
        host_port      = 5341
        container_port = 5341
        protocol       = "tcp"
        listen_address = "127.0.0.1"
      }
      # Opentelemetry
      extra_port_mappings {
        host_port      = 4317
        container_port = 4317
        protocol       = "tcp"
        listen_address = "127.0.0.1"
      }
      extra_port_mappings {
        host_port      = 4318
        container_port = 4318
        protocol       = "tcp"
        listen_address = "127.0.0.1"
      }
      # Jaeger
      extra_port_mappings {
        host_port      = 6831
        container_port = 6831
        protocol       = "tcp"
        listen_address = "127.0.0.1"
      }
      extra_port_mappings {
        host_port      = 6832
        container_port = 6832
        protocol       = "tcp"
        listen_address = "127.0.0.1"
      }
      # RabbitMQ
      extra_port_mappings {
        host_port      = 5672
        container_port = 5672
        protocol       = "tcp"
        listen_address = "127.0.0.1"
      }
      # Loki
      extra_port_mappings {
        host_port      = 3100
        container_port = 3100
        protocol       = "tcp"
        listen_address = "127.0.0.1"
      }
    }
    node {
      role = "worker"
    }
    node {
      role = "worker"
    }
  }
  depends_on = [
    docker_network.kind_network
  ]
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
  create_duration = "20s"
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