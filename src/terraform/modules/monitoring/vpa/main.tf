resource "helm_release" "vpa" {
  name       = "vpa"
  chart      = "vpa"
  repository = "https://charts.fairwinds.com/stable"
  version    = var.helm_release
  namespace  = var.namespace
  values = [
    "${file("${path.module}/vpa-values.yaml")}"
  ]
}


