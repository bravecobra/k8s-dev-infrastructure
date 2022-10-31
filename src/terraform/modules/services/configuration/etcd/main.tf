resource "random_password" "init_password" {
  length           = 8
  special          = false
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "helm_release" "etcd" {
  name       = "etcd"
  chart      = "etcd"
  repository = "https://charts.bitnami.com/bitnami"
  version    = var.helm_release
  namespace  = var.namespace
  values = [
    templatefile("${path.module}/etcd-values.yaml", {
      password : random_password.init_password.result
    }),
  ]
}

resource "kubectl_manifest" "etcd-cert" {
  yaml_body = templatefile("${path.module}/templates/etcd-cert.yaml", {
    domain-name = var.domain-name,
    namespace   = var.namespace
  })
  depends_on = [
    helm_release.etcd
  ]
}

resource "kubectl_manifest" "e3w-config" {
  yaml_body = templatefile("${path.module}/templates/e3w-config.yaml", {
    domain-name = var.domain-name,
    namespace   = var.namespace,
    password    = random_password.init_password.result
  })
  depends_on = [
    helm_release.etcd
  ]
}

resource "kubectl_manifest" "e3w-deployment" {
  yaml_body = templatefile("${path.module}/templates/e3w-deployment.yaml", {
    domain-name = var.domain-name,
    namespace   = var.namespace
  })
  depends_on = [
    helm_release.etcd,
    kubectl_manifest.e3w-config
  ]
}

resource "kubectl_manifest" "e3w-service" {
  yaml_body = templatefile("${path.module}/templates/e3w-service.yaml", {
    domain-name = var.domain-name,
    namespace   = var.namespace
  })
  depends_on = [
    helm_release.etcd
  ]
}

resource "kubectl_manifest" "e3w-ingress" {
  yaml_body = templatefile("${path.module}/templates/e3w-ingress.yaml", {
    domain-name = var.domain-name,
    namespace   = var.namespace
  })
  depends_on = [
    helm_release.etcd,
    kubectl_manifest.etcd-cert
  ]
}
