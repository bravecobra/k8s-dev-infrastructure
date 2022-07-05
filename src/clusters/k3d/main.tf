resource "docker_network" "k3d_network" {
  name = "k3d"
  driver = "bridge"
  ipv6 = true
  ipam_config {
      subnet = "fc00:f853:ccd:e793::/64"
  }
  ipam_config {
      subnet = "172.19.0.0/16"
      gateway = "172.19.0.1"
  }
  options = {
    "com.docker.network.bridge.enable_ip_masquerade "= "true"
    "com.docker.network.driver.mtu" = "1500"
  }
}

locals {
  is_windows = substr(pathexpand("~"), 0, 1) == "/" ? false : true
}

resource "random_integer" "port" {
  min = 8000
  max = 8099
}

// locals {
//   host_lb_port = (var.k3d_host_lb_port != "" ? var.k3d_host_lb_port : random_integer.port.result)
// }

resource "local_file" "cluster-config" {
  for_each = toset(var.k3d-cluster-name)
  content     = templatefile("${path.module}/${each.key}-template.yaml", {
    cluster-name = each.key,
    server-node-count   = var.server-node-count,
    worker-node-count   = var.worker-node-count,
    k3s-version         = var.k3s-version,
    cluster-domain      = var.k3d-cluster-domain,
    cluster-ip          = var.k3d-cluster-ip,
    cluster-port        = var.k3d-cluster-port,
    network             = docker_network.k3d_network.name,
    expose_azurite      = var.expose_azurite,
    expose_seq          = var.expose_seq
    expose_jaeger       = var.expose_jaeger,
    expose_opentelemetry = var.expose_opentelemetry,
    expose_prometheus   = var.expose_prometheus,
    expose_elasticsearch = var.expose_elasticsearch,
    expose_rabbitmq      = var.expose_rabbitmq,
    expose_loki         = var.expose_loki,
  })

  filename = "${path.module}/k3s-${var.cluster-name}.yaml"
}

resource "null_resource" "cluster" {
  for_each = toset(var.k3d-cluster-name)
  triggers = {
    agent_count   = var.worker-node-count
    server_count  = var.server-node-count
    ip            = var.k3d-cluster-ip
    port          = var.k3d-cluster-port
    k3s_version   = var.k3s-version
  }
  provisioner "local-exec" {
    command = "k3d cluster create ${each.key} --config=${local_file.cluster-config[each.key].filename}"
  }
}

resource "null_resource" "cluster_delete" {
  for_each = toset(var.k3d-cluster-name)
  provisioner "local-exec" {
    command = "k3d cluster delete ${each.key}"
    when    = destroy
  }
}
