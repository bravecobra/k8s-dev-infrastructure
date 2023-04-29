resource "docker_network" "k3d_network" {
  name   = "k3d"
  driver = "bridge"
  ipv6   = false
  # ipam_config {
  #   subnet = "fc00:f853:ccd:e793::/64"
  # }
  ipam_driver = "default"
  ipam_config {
    subnet  = var.k3d-network-subnet
    gateway = var.k3d-network-gateway
  }
  ingress    = false
  attachable = true
  options = {
    "com.docker.network.bridge.enable_ip_masquerade " = "true"
    "com.docker.network.driver.mtu"                   = "1500"
  }
}

locals {
  is_windows = substr(pathexpand("~"), 0, 1) == "/" ? false : true
  envs       = { for tuple in regexall("(.*)=(.*)", file(".env")) : tuple[0] => sensitive(tuple[1]) }
}

resource "local_file" "cluster-config" {
  for_each = toset(var.k3d-cluster-name)
  content = templatefile("${path.module}/${each.key}-template.yaml", {
    cluster-name         = each.key,
    server-node-count    = var.server-node-count,
    worker-node-count    = var.worker-node-count,
    k3s-version          = var.k3s-version,
    cluster-domain       = var.k3d-cluster-domain,
    cluster-ip           = var.k3d-cluster-ip,
    cluster-port         = var.k3d-cluster-port,
    network              = docker_network.k3d_network.name,
    expose_azurite       = var.expose_azurite,
    expose_seq           = var.expose_seq
    expose_jaeger        = var.expose_jaeger,
    expose_opentelemetry = var.expose_opentelemetry,
    expose_rabbitmq      = var.expose_rabbitmq,
    expose_loki          = var.expose_loki,
    expose_rds_mssql     = var.expose_rds_mssql,
    expose_rds_oracle    = var.expose_rds_oracle,
    expose_rds_mysql     = var.expose_rds_mysql,
    expose_rds_mariadb   = var.expose_rds_mariadb,
    expose_rds_postgres  = var.expose_rds_postgres,
    expose_nosql_mongodb = var.expose_nosql_mongodb,
    expose_redis         = var.expose_redis,
  })

  filename = "${path.module}/k3s-${var.cluster-name}.yaml"
}

resource "null_resource" "cluster_create" {
  for_each = toset(var.k3d-cluster-name)
  triggers = {
    agent_count  = var.worker-node-count
    server_count = var.server-node-count
    ip           = var.k3d-cluster-ip
    port         = var.k3d-cluster-port
    k3s_version  = var.k3s-version
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
