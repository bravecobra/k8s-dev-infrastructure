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
