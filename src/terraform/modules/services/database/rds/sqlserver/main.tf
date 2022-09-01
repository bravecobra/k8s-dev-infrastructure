resource "kubectl_manifest" "mssql-cert" {
  yaml_body = templatefile("${path.module}/templates/mssql-cert.yaml", {
    domain-name = var.domain-name
    namespace = var.namespace
  })
}

resource "random_password" "init_password" {
  length           = 8
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "helm_release" "mssql" {
  name       = "sqlserver"
  chart      = "mssqlserver-2022"
  repository = "https://simcubeltd.github.io/simcube-helm-charts/"
  version    = var.helm_release
  namespace  = var.namespace
  wait       = true
  wait_for_jobs = true
  values = [
    templatefile("${path.module}/mssql-values.yaml", {
      domain-name = var.domain-name,
      mssqlPassword = random_password.init_password.result})
  ]
  depends_on = [
    random_password.init_password
  ]
}

resource "kubectl_manifest" "mssql-ingress" {
  count = var.expose_mssql ? 1 : 0
  yaml_body = templatefile("${path.module}/templates/ingress.yaml", {
    domain-name = var.domain-name
    namespace = var.namespace
  })
  depends_on = [
    helm_release.mssql
  ]
}