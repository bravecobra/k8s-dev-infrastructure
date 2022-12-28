resource "kubectl_manifest" "goldilocks-cert" {
  yaml_body = templatefile("${path.module}/templates/goldilocks-cert.yaml", {
    domain-name = var.domain-name
    namespace   = var.namespace
  })
}

resource "helm_release" "goldilocks" {
  name       = "goldilocks"
  chart      = "goldilocks"
  repository = "https://charts.fairwinds.com/stable"
  version    = var.helm_release
  namespace  = var.namespace
  values = [
    templatefile("${path.module}/goldilocks-values.yaml", {
        domain-name = var.domain-name
        namespace   = var.namespace
    })
  ]
  depends_on = [
    kubectl_manifest.goldilocks-cert
  ]
}
