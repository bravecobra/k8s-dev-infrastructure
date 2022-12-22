resource "kubectl_manifest" "mariadb-cert" {
  yaml_body = templatefile("${path.module}/templates/mariadb-cert.yaml", {
    domain-name = var.domain-name
    namespace   = var.namespace
  })
}

resource "random_password" "init_password" {
  length           = 8
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "helm_release" "mariadb" {
  name          = "mariadb"
  chart         = "mariadb"
  repository    = "https://charts.bitnami.com/bitnami"
  version       = var.helm_release
  namespace     = var.namespace
  wait          = true
  wait_for_jobs = true
  values = [
    templatefile("${path.module}/mariadb-values.yaml", {
      domain-name  = var.domain-name,
      storageclass = var.storageclass,
    rootPassword = random_password.init_password.result })
  ]
  depends_on = [
    random_password.init_password
  ]
}

resource "kubectl_manifest" "mariadb-ingress" {
  count = var.expose_mariadb ? 1 : 0
  yaml_body = templatefile("${path.module}/templates/ingress.yaml", {
    domain-name = var.domain-name
    namespace   = var.namespace
  })
  depends_on = [
    helm_release.mariadb
  ]
}
