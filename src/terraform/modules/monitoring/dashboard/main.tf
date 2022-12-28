resource "kubectl_manifest" "dashboard-cert" {
  yaml_body = templatefile("${path.module}/templates/dashboard-cert.yaml", {
    domain-name = var.domain-name
    namespace   = var.namespace
  })
}

resource "helm_release" "dashboard" {
  name       = "dashboard"
  chart      = "kubernetes-dashboard"
  repository = "https://kubernetes.github.io/dashboard/"
  version    = var.helm_release
  namespace  = var.namespace
  values = [
    templatefile("${path.module}/dashboard-values.yaml", {
      domain-name = var.domain-name
      namespace   = var.namespace
    })
  ]
  depends_on = [
    kubectl_manifest.dashboard-cert
  ]
}
