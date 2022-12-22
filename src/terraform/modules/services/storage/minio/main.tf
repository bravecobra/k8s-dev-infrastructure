resource "kubectl_manifest" "minio-cert" {
  yaml_body = templatefile("${path.module}/templates/minio-cert.yaml", {
    domain-name = var.domain-name
    namespace   = var.namespace
  })
}

resource "random_password" "init_password" {
  length           = 8
  special          = false
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "helm_release" "minio" {
  name         = "minio"
  chart        = "minio"
  repository   = "https://charts.min.io/"
  version      = var.helm_release
  namespace    = var.namespace
  timeout      = 150
  values = [
    templatefile("${path.module}/minio-values.yaml", {
      domain-name      = var.domain-name,
      namespace        = var.namespace,
      storageclass     = var.storageclass,
      init_password    = random_password.init_password.result,
      metrics_external = var.metrics,
    }),
  ]
}