resource "kubectl_manifest" "postgres-cert" {
  yaml_body = templatefile("${path.module}/templates/postgres-cert.yaml", {
    domain-name = var.domain-name
    namespace   = var.namespace
  })
}

resource "random_password" "init_password" {
  length           = 8
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "helm_release" "postgres" {
  name          = "postgres"
  chart         = "postgresql"
  repository    = "https://charts.bitnami.com/bitnami"
  version       = var.helm_release
  namespace     = var.namespace
  wait          = true
  wait_for_jobs = true
  values = [
    templatefile("${path.module}/postgres-values.yaml", {
      domain-name  = var.domain-name,
      storageclass = var.storageclass,
    postgresPassword = random_password.init_password.result })
  ]
  depends_on = [
    random_password.init_password
  ]
}

resource "kubectl_manifest" "postgres-ingress" {
  count = var.expose_postgres ? 1 : 0
  yaml_body = templatefile("${path.module}/templates/ingress.yaml", {
    domain-name = var.domain-name
    namespace   = var.namespace
  })
  depends_on = [
    helm_release.postgres
  ]
}