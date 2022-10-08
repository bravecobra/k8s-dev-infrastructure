resource "kubectl_manifest" "mongodb-cert" {
  yaml_body = templatefile("${path.module}/templates/mongodb-cert.yaml", {
    domain-name = var.domain-name
    namespace   = var.namespace
  })
}

resource "random_password" "init_password" {
  length           = 8
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "helm_release" "mongodb" {
  name          = "mongodb"
  chart         = "mongodb"
  repository    = "https://charts.bitnami.com/bitnami"
  version       = var.helm_release
  namespace     = var.namespace
  wait          = true
  wait_for_jobs = true
  values = [
    templatefile("${path.module}/mongodb-values.yaml", {
      domain-name = var.domain-name,
    rootPassword = random_password.init_password.result })
  ]
  depends_on = [
    random_password.init_password
  ]
}

resource "kubectl_manifest" "mongodb-ingress" {
  count = var.expose_mongodb ? 1 : 0
  yaml_body = templatefile("${path.module}/templates/ingress.yaml", {
    domain-name = var.domain-name
    namespace   = var.namespace
  })
  depends_on = [
    helm_release.mongodb
  ]
}
