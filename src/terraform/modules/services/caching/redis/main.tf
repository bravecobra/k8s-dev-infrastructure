resource "kubectl_manifest" "redis-cert" {
  yaml_body = templatefile("${path.module}/templates/redis-commander/redis-cert.yaml", {
    domain-name = var.domain-name
    namespace   = var.namespace
  })
}

resource "random_password" "init_password" {
  length           = 8
  special          = false
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "helm_release" "redis" {
  name       = "redis"
  chart      = "redis"
  repository = "https://charts.bitnami.com/bitnami"
  version    = var.helm_release
  namespace  = var.namespace
  values = [
    templatefile("${path.module}/redis-values.yaml", {
      password : random_password.init_password.result
      replica_count : var.replica_count
    }),
  ]
}

resource "kubectl_manifest" "redis-ingress" {
  count = var.expose_redis ? 1 : 0
  yaml_body = templatefile("${path.module}/templates/ingress.yaml", {
    domain-name = var.domain-name
    namespace   = var.namespace
  })
  depends_on = [
    helm_release.redis,
  ]
}

resource "kubectl_manifest" "redis_commander_deployment" {
  yaml_body = templatefile("${path.module}/templates/redis-commander/deployment.yaml", {
    namespace   = var.namespace,
    domain-name = var.domain-name
    password    = random_password.init_password.result
  })
  depends_on = [
    random_password.init_password
  ]
}

resource "kubectl_manifest" "redis_commander_service" {
  yaml_body = templatefile("${path.module}/templates/redis-commander/service.yaml", {
    namespace   = var.namespace,
    domain-name = var.domain-name
  })
}

resource "kubectl_manifest" "redis_commander_ingress" {
  yaml_body = templatefile("${path.module}/templates/redis-commander/ingress.yaml", {
    namespace   = var.namespace,
    domain-name = var.domain-name
  })
}